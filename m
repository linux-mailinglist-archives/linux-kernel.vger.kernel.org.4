Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960F5ED27E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiI1BKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiI1BKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FCA5E66B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664327407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yuhYrI3O2et4AQDqfdAc7XVomQ7XZIW92EUt5M6cRFY=;
        b=bSfDT5vrDpi0thvhRS5vBXsZX5BiB9+peCrLMKnokv4z9C9iOhr9ZHK01Xn9HwfWwRhqGZ
        63cFKyYI054sBdi2U29KvylJXIMHCSnXCKNaqetULAaWLmW/3Aznze9LBuh/sAAbqKsME7
        gkE7mqkk97qsq18WHmqAGDAc30zP5b0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-53R5vA26MeOJJtwaB5DeVw-1; Tue, 27 Sep 2022 21:10:06 -0400
X-MC-Unique: 53R5vA26MeOJJtwaB5DeVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8801A185A78F;
        Wed, 28 Sep 2022 01:10:05 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 350B1C15BA4;
        Wed, 28 Sep 2022 01:09:55 +0000 (UTC)
Date:   Wed, 28 Sep 2022 09:09:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Message-ID: <YzOe3pYmn5qO9lFb@T590>
References: <20220914225621.415631-1-bvanassche@acm.org>
 <20220914225621.415631-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914225621.415631-7-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 03:56:20PM -0700, Bart Van Assche wrote:
> Some kernel modules call device_del() from their module exit code and
> schedule asynchronous work from inside the .release callback without waiting
> until that callback has finished. As an example, many SCSI LLD drivers call

It isn't only related with device, any kobject has such issue, or any
reference counter usage has similar potential risk, see previous discussion:

https://lore.kernel.org/lkml/YsZm7lSXYAHT14ui@T590/

IMO, it is one fundamental problem wrt. module vs. reference counting or
kobject uses at least, since the callback depends on module code
segment.

> scsi_remove_host() from their module exit code. scsi_remove_host() may
> invoke scsi_device_dev_release_usercontext() asynchronously.
> scsi_device_dev_release_usercontext() uses the host template pointer and
> that pointer usually exists in static storage in the SCSI LLD. Support
> using the module reference count to keep the module around until
> asynchronous module exiting has completed by waiting in the delete_module()
> system call until the module reference count drops to zero.

The issue can't be addressed by the normal mod->refcnt, since user need
to unload module when the device isn't used.


thanks,
Ming

