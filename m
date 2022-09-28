Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B855ED15E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiI1AC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI1ACx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:02:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E7B6D54;
        Tue, 27 Sep 2022 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=guf6A20S3MwV/sozfojk73A9a5gLzuwZOHcY81yWs9s=; b=V+2f75PvljF3lRCCcfchpHgtNm
        Cb5hEGrH1L7Clwr8w8F7ZIUtHCA9POwQ/uCm0CYoJu+DUAoAMFK8Dbg9Wn6nkXqLQ9zBgNLPKvlYG
        7iv7QdXWG0OAjOWs4gprIa7W2gbycW42Cw1Yr1Y0mTNY7N9zVAi9hJh3154PBmlK0vkYTeQ3BBWNp
        UE8exWdMXdRjbMME6NZF08HjFatVITEMX2av+3crRXQDLtkeQYPW0COvoZLi7/69j0YWfZzodsGoP
        jQg1zzz4940cYoA39xTRhJc6Ff/82hZ/QTZZX2Evyn9i5Khn2aY31vjgF6+GXzAj239pUHPHfLzW8
        ns9Wsx+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odKXE-00DELX-JK; Wed, 28 Sep 2022 00:02:44 +0000
Date:   Tue, 27 Sep 2022 17:02:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Message-ID: <YzOPJHSQsPtc5o0Y@bombadil.infradead.org>
References: <20220914225621.415631-1-bvanassche@acm.org>
 <20220914225621.415631-7-bvanassche@acm.org>
 <a4084b27-dd2d-10df-493c-35998eed664c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4084b27-dd2d-10df-493c-35998eed664c@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:13:40AM -0700, Bart Van Assche wrote:
> On 9/14/22 15:56, Bart Van Assche wrote:
> > Some kernel modules call device_del() from their module exit code and
> > schedule asynchronous work from inside the .release callback without waiting
> > until that callback has finished. As an example, many SCSI LLD drivers call
> > scsi_remove_host() from their module exit code. scsi_remove_host() may
> > invoke scsi_device_dev_release_usercontext() asynchronously.
> > scsi_device_dev_release_usercontext() uses the host template pointer and
> > that pointer usually exists in static storage in the SCSI LLD. Support
> > using the module reference count to keep the module around until
> > asynchronous module exiting has completed by waiting in the delete_module()
> > system call until the module reference count drops to zero.
> 
> Hi Luis,
> 
> I'd like to know your opinion about this patch since you are the maintainer
> of the kernel module system.

See this patch which extends the documentation of try_module_get():

https://lkml.kernel.org/r/20211029184500.2821444-7-mcgrof@kernel.org

You can ignore discussion around the thread as sadly it is just
irrelevant stuff not about that patch. But the logic it spells out
is still true.

So, in short, using try_module_get() on exit is actually the wrong
thing to do and it is no surprise it would fail. I haven't gotten
yet around to reviewing Mauro's driver API which let's you unbind
drivers, but it sounds related so I CC'd you on that.

So I'd like to ask instead if an alternative to using try_module_get()
on exit would be better here and for the future.

  Luis
