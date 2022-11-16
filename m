Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB162CD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiKPWMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiKPWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681246A6B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668636655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vamPlcLskGy2JvIhU266turZK2l7Sx2cyKxaPLx7j8=;
        b=UCl8KVLM0z2MK4xQK7FM95cw1drlb8V4IZB/uL46vzdOUgVXrE0ebR9LNT07nr8UtnVr9p
        DWNz2yHF9E0DLt+IrF/pWSz9dLLZ/odiYGl+J8PJx+TbxbIDtEvcNjywFYupdT+YTS4rZ/
        RnNOG8WjIDThScRhmU8692OIciiq6X0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-ialSBMN9OgOxk9dWf5hm7g-1; Wed, 16 Nov 2022 17:10:54 -0500
X-MC-Unique: ialSBMN9OgOxk9dWf5hm7g-1
Received: by mail-qk1-f200.google.com with SMTP id bj1-20020a05620a190100b006fa12a05188so50135qkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vamPlcLskGy2JvIhU266turZK2l7Sx2cyKxaPLx7j8=;
        b=63pgw862SWro080J6qosUut+YUJM373jS97IfISImY0rmI02+OAVmLmGyR9iPhMRc8
         S7oSTj9Eq1IBy4fPFHOY9giB+dJYoQcAJ1J9Ww2tHJxVSaCodvAO8q+g0c21UIX3u1ig
         /QkYfhB3fpP9/K6CX/6FoTDQO1F2o7bJufM658O/PyxwAh9jCC715xM72xksRqpyaXsG
         qsqK0Da05A/stw/UbUd/i/XTQYvxjUA+zfGD4H8rn4Rh2MNICVhu6uZWqxVbM9Qo+TY0
         MDt3cP4Pgjtba1cAno6E7L1CLIwuA2GPrbOH75RPg+sYvxfCP4n3RjA+ORY07UxQ+HuW
         ESpg==
X-Gm-Message-State: ANoB5pnqQUHNxks6zc+FBNTiZI77QdYEZaZiRZ/b8omyk5s9Gz8pcaz8
        EMu2yXI4KVVixGj/7DZikk9hVEUXeeXhZGHFAy8tXri/FasAgN6CiokLXc/ZL09Ab2DVCHutL9/
        IF3KS9c5GzgiNOyUD/eeqzlQ=
X-Received: by 2002:a0c:f4cd:0:b0:4b1:8ec4:4464 with SMTP id o13-20020a0cf4cd000000b004b18ec44464mr173723qvm.16.1668636654006;
        Wed, 16 Nov 2022 14:10:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4znPzbOMmRcBIPotkDkuJjcA84kJF/jJYUJhZDK9rm9yXJQWV/5W2Fydvh5O0bt2+81eunGg==
X-Received: by 2002:a0c:f4cd:0:b0:4b1:8ec4:4464 with SMTP id o13-20020a0cf4cd000000b004b18ec44464mr173707qvm.16.1668636653766;
        Wed, 16 Nov 2022 14:10:53 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006f7ee901674sm10691245qkb.2.2022.11.16.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:10:53 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:10:52 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 01/10] block: clear ->slave_dir when dropping the main
 slave_dir reference
Message-ID: <Y3Vf7LYexIXiUeOE@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> Zero out the pointer to ->slave_dir so that the holder code doesn't
> incorrectly treat the object as alive when add_disk failed or after
> del_gendisk was called.
> 
> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

