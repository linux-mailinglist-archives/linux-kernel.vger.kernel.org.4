Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD35EEAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiI2BKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiI2BKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0AB0B00
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664413847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2btDcA0Eb0Lbvuk+gmwVVQo3+wu4HeJ6n54Ununsy7E=;
        b=hqNsHXMq9NyJL7OahbLzLF/J1rVmV/QL6GEmiwcjnuWhACWHPfVXlvMSfMu3g04nEPuaUS
        1VfcYCqx/zjGvoeWCOjrORvclcS8IlRRk19DAvdYz/5fcaDYmSHQC9pDvhJmz5+3+o8Mxd
        1UOVsrempkzgwlc/PbPWZD2npCpTMsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-XS4IEKxKMMCpFzgb3vguXg-1; Wed, 28 Sep 2022 21:10:42 -0400
X-MC-Unique: XS4IEKxKMMCpFzgb3vguXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C4D980206D;
        Thu, 29 Sep 2022 01:10:41 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B301121315;
        Thu, 29 Sep 2022 01:10:32 +0000 (UTC)
Date:   Thu, 29 Sep 2022 09:10:27 +0800
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
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Message-ID: <YzTwgxX+WMuJyAJy@T590>
References: <20220914225621.415631-1-bvanassche@acm.org>
 <20220914225621.415631-7-bvanassche@acm.org>
 <YzOe3pYmn5qO9lFb@T590>
 <2acc2220-65dc-4af5-ffd3-997f779d41c0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acc2220-65dc-4af5-ffd3-997f779d41c0@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:27:07PM -0700, Bart Van Assche wrote:
> On 9/27/22 18:09, Ming Lei wrote:
> > On Wed, Sep 14, 2022 at 03:56:20PM -0700, Bart Van Assche wrote:
> > > Some kernel modules call device_del() from their module exit code and
> > > schedule asynchronous work from inside the .release callback without waiting
> > > until that callback has finished. As an example, many SCSI LLD drivers call
> > 
> > It isn't only related with device, any kobject has such issue, or any
> > reference counter usage has similar potential risk, see previous discussion:
> > 
> > https://lore.kernel.org/lkml/YsZm7lSXYAHT14ui@T590/
> > 
> > IMO, it is one fundamental problem wrt. module vs. reference counting or
> > kobject uses at least, since the callback depends on module code
> > segment.
> > 
> > > scsi_remove_host() from their module exit code. scsi_remove_host() may
> > > invoke scsi_device_dev_release_usercontext() asynchronously.
> > > scsi_device_dev_release_usercontext() uses the host template pointer and
> > > that pointer usually exists in static storage in the SCSI LLD. Support
> > > using the module reference count to keep the module around until
> > > asynchronous module exiting has completed by waiting in the delete_module()
> > > system call until the module reference count drops to zero.
> > 
> > The issue can't be addressed by the normal mod->refcnt, since user need
> > to unload module when the device isn't used.
> 
> Hi Ming,
> 
> How about removing support for calling scsi_device_put() from atomic context
> as is done in the untested patch below?

That can't work.

The problem is that no existed mechanism can guarantee that kobject reference
drops to zero inside module_exit().


Thanks,
Ming

