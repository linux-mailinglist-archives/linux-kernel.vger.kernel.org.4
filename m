Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7C72AC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjFJOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFJOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:40:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9081730EC;
        Sat, 10 Jun 2023 07:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C47360F58;
        Sat, 10 Jun 2023 14:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE5FC4339B;
        Sat, 10 Jun 2023 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686408002;
        bh=b7Ik0zRfTsBIqeOl18BPqRgF8nNcLpxm1RVGGPM/mi0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=SJeF4Jc2us5hwri8rSuscA8pOaSh+e84B/uiIsFUJLGTdjF8G6255kK7nqgP73LzL
         ZcWO2le8RQ2JfhS08jYQLC9WcUyCNnrmVm+GZFRyN8XfBr2d5TaNLDG9NLawmgFCp7
         KakpQK56b5oHFz605Mkuka+9cKYwNxx2be+B690/3RLmKtyFXBVHGaUvEVMYL4wtON
         7lHwXQXDOwovRQWcszMynPtCmdPWpm/znY1fnjjw5I1fh9PPvrtvFC0iPX6Iz8UJFS
         pNMeeiWNarOmKdd+aLuFWvg3CF5ohxk+SvXNfBfUIccMVv14rpx4/QPxpm3l5Eq5JT
         vOvfy8Tak23WA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-39aa8a055e0so1304225b6e.0;
        Sat, 10 Jun 2023 07:40:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDx+FErH92o+jHzgoMTeH5iDqaBLuWQ6R1i7KhZNvJ0AqXl3nEXL
        DhjPvV8LSxsE1/QmqVumoBTm+phlXVpxgroDdIE=
X-Google-Smtp-Source: ACHHUZ4DOzpCq7JDOBWrdPbgi6hfe6UmDzpD26BAdfRCKGpSkH0YDRsGo4+6lsGOiJ6goaElYnEVoOJ3Lb414oEtjJU=
X-Received: by 2002:a05:6808:144c:b0:398:50f1:ad19 with SMTP id
 x12-20020a056808144c00b0039850f1ad19mr1123404oiv.39.1686408001597; Sat, 10
 Jun 2023 07:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:774b:0:b0:4df:6fd3:a469 with HTTP; Sat, 10 Jun 2023
 07:40:00 -0700 (PDT)
In-Reply-To: <20230609050636.27669-1-luhongfei@vivo.com>
References: <20230609050636.27669-1-luhongfei@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 10 Jun 2023 23:40:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8=asCzeYTNoqyHO+-EyOMWqNLY2C69YjpqrKQyKapBNA@mail.gmail.com>
Message-ID: <CAKYAXd8=asCzeYTNoqyHO+-EyOMWqNLY2C69YjpqrKQyKapBNA@mail.gmail.com>
Subject: Re: [PATCH] fs: smb: server: Replace the ternary conditional operator
 with min()
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        "open list:KERNEL SMB3 SERVER (KSMBD)" <linux-cifs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-09 14:06 GMT+09:00, Lu Hongfei <luhongfei@vivo.com>:
> It would be better to replace the traditional ternary conditional
> operator with min() in compare_sids.
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
