Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBD268F116
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBHOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjBHOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:46:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC697303E7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:45:59 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z1so19477336plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9APWzIV+7Bk+eMZXMnkea/loMWDb0j2eNn6crGTD7M=;
        b=ZzbZBQeo7ockhhPlfg9a2V8MeTjZhGsnS0ea5DXCkI5R6D6KgPTXGSbRky5Gb8AsJH
         /2mudNx8wLHe69wFIzg4gDl7z+7+b25Phwl8RVR7ESGVMp2CMetkxW8omZe82SQoy9aO
         L9KDhWNJLpAkJmabs93q1ajZOPMt+3ceuBQisTjtgkoMAN67A0SreAB01Z4HCNC71zrK
         4VfLSzWfIofvrtSx+aCS7g5VsGfs9GyAkbToQYUPgmErKkpb5Hcb26jVG2/kk5XH6ObO
         MfyAkQzXuRPDY42gCXtpbeJXR1ZVuj9bc7WGTyly0DMxK2uTOG9Y6F/mlci2/Mol8bPN
         9unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9APWzIV+7Bk+eMZXMnkea/loMWDb0j2eNn6crGTD7M=;
        b=v1VeQme1RLHS2FSGvhvpqUnyL8pZJTJKO0+z0FIsqyHMapMHlQa2qMuTxQXe7VVJUL
         gKHPVUg+Pyy2G+VG7nl3r+/wPf4C4X+jwGwGpNdngTltiMStk73GdnQJ1HM9tzt/NG8Z
         2fL7QsrjQBwGdv9jMujhwN6O4owo4+d8iOOjjnss1sA9YgNAuoYyh+jCCouC5VNyOP8U
         /YfeN69eDSvWxjmXYdRj+/K5yPJ4euck/mqsmu+XO0EerpV/zHXl20fT9vW1yeMHjhwS
         nQ+tJSUQT0TwByCh7+zqkVk1EaL7+OwEN9mSP8YsZPJQTQFVqyD65fY44mK1rXd8TBGj
         3zlA==
X-Gm-Message-State: AO0yUKUUM7vd3KmCpphw62KmhdDg/Xe7g2q7t/T/vbIdxrZhVumX0455
        P+c80+dTjerZrGG1FZafMrGqxQ==
X-Google-Smtp-Source: AK7set/W/mntM9Gw7Sjb3X5zca5NiuZodd+vepBxl0Lxlr21DuWvj088eRFNvKzW4uTdJaxc1hQZAA==
X-Received: by 2002:a17:903:404c:b0:198:af4f:de0d with SMTP id n12-20020a170903404c00b00198af4fde0dmr234228pla.13.1675867559188;
        Wed, 08 Feb 2023 06:45:59 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902b70300b00193020e8a90sm11052055pls.294.2023.02.08.06.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:45:58 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:45:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kvm@vger.kernel.org, shahuang@redhat.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: KVM: Replace optarg with arg in
 guest_modes_cmdline
Message-ID: <Y+O1o4TvO1ajPsgi@google.com>
References: <20230202025716.216323-1-shahuang@redhat.com>
 <167582135972.455074.6960378545703076467.b4-ty@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167582135972.455074.6960378545703076467.b4-ty@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023, Sean Christopherson wrote:
> On Thu, 02 Feb 2023 10:57:15 +0800, shahuang@redhat.com wrote:
> > The parameter arg in guest_modes_cmdline not being used now, and the
> > optarg should be replaced with arg in guest_modes_cmdline.
> > 
> > And this is the chance to change strtoul() to atoi_non_negative(), since
> > guest mode ID will never be negative.
> > 
> > 
> > [...]
> 
> Applied to kvm-x86 selftests, thanks!
> 
> [1/1] selftests: KVM: Replace optarg with arg in guest_modes_cmdline
>       https://github.com/kvm-x86/linux/commit/62f86202d76d

I force pushed to selftests because of a goof on my end, new SHA-1 is:

  https://github.com/kvm-x86/linux/commit/7ae69d7087a9
