Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037106A5DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjB1QzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjB1QzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:55:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347D36085
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677603142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZikqzZIkDbGi1O4pYDEQeFbbNJeZAINLFAEHIXoh3c=;
        b=B6b+DFJGcH4/bKs3Ti6hxq5bhvHjAZ6QPKokE5FRWrFYgHjRV9Q6XaGzjNUpj7t4ZGaG7A
        r/yZusreSiLVX0W9yebGssf0sfIh1qWfUuJ15zDixIOyslYC99TdKyMeAJl/WqHq+VBhcN
        TzRYvK6Nwp3Nmx98ErEmjdzltQyUsCY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-_d5LXIZSPl-Pu2ZwzvyjbA-1; Tue, 28 Feb 2023 11:52:19 -0500
X-MC-Unique: _d5LXIZSPl-Pu2ZwzvyjbA-1
Received: by mail-pf1-f198.google.com with SMTP id i7-20020a626d07000000b005d29737db06so5395023pfc.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677603138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZikqzZIkDbGi1O4pYDEQeFbbNJeZAINLFAEHIXoh3c=;
        b=t9Hj4rolG4D5zrfuESOz1K6HJD/PDeW7GUqaOxlpLmJzzMZJTfPpws/y6tC7G0wvf4
         vh8ckSTZXXZNZ/ArCdEjV1VQy0+rmvZ+csOyF58X1W3n2FwbgceoPgahaOF3wnITT4qB
         Plt+utUBiichGXXykXOSM1PYvIR10ZuGrVUseAvPrjFeOudRBXED/3eKIgWegVRPgyT1
         drggHylMrbE8GLj1eZMDM7Zj8Uqut7bx+Ly7q6H4FJXUVAnbAup4noJ3C31xBgOimae5
         7RkpCCpONLBsjMOGtzaNXQCGYQg1UEpjMz/itBI639rP0/Fu6neJl1zgU4T4mvVU7uFd
         +tLg==
X-Gm-Message-State: AO0yUKUWPhsIYcxxYYUI8D2S+ERHApn5RXErNDu22hMm8tTBtD/+a1Yo
        XmJJ4+BHlIw0Pg/aLcQ+cOVwO7ty/wtt/wfY15P3702sBzB2B2qj71uoYnPY1DnAbcszVze69Jy
        0qRSV9wJP1XJw3yz4pIjUZUZP
X-Received: by 2002:a05:6a20:6903:b0:c7:164c:edf7 with SMTP id q3-20020a056a20690300b000c7164cedf7mr3802641pzj.36.1677603138521;
        Tue, 28 Feb 2023 08:52:18 -0800 (PST)
X-Google-Smtp-Source: AK7set96tFfE/DyE8/J9QYLTy3Y4VmaD8BB4CdDfyRG/rfxWoIeZLabIq1dp5aLI+BWFJOcvwmTCbA==
X-Received: by 2002:a05:6a20:6903:b0:c7:164c:edf7 with SMTP id q3-20020a056a20690300b000c7164cedf7mr3802620pzj.36.1677603138119;
        Tue, 28 Feb 2023 08:52:18 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id i194-20020a636dcb000000b004f1e73b073bsm5886962pgc.26.2023.02.28.08.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:52:17 -0800 (PST)
Date:   Wed, 1 Mar 2023 01:52:13 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+b563d33852b893653a9e@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: caif: Fix use-after-free in
 cfusbl_device_notify()
Message-ID: <Y/4xPYHjl4X1D30L@kernel-devel>
References: <20230225182820.4048336-1-syoshida@redhat.com>
 <20230227182800.02ddf83f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227182800.02ddf83f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:28:00PM -0800, Jakub Kicinski wrote:
> On Sun, 26 Feb 2023 03:28:20 +0900 Shigeru Yoshida wrote:
> > syzbot reported use-after-free in cfusbl_device_notify() [1].  This
> > causes a stack trace like below:
> 
> Please repost with the correct fixes tag, presumably:
> 
> Fixes: 7ad65bf68d70 ("caif: Add support for CAIF over CDC NCM USB interface")
> 
> Please make sure you CC the authors of that commit.

Sorry, I'll be more careful.  I'll prepare v2 patch.

Thanks,
Shigeru

> 

