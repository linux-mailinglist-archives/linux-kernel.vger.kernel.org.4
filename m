Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0865E4BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjAEEkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjAEEkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:40:42 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBFE41D7B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:40:41 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-476e643d1d5so387676987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 20:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3RKDUpLHSH4OD7mBSrVtKOYMv8CoVoHckaHZEsIkq4=;
        b=RQIVRGo/f16meY9QNhwDHd5XV7H+7Q0kl6ORpJs2ivxGA7VlKL9MUklTWB6DRLKkXs
         WPzOx0IXj3aKuIyb02gGvX+mLXzpbmUaU2MVjnZEMBBpqRKLU9C2AF79GJoXOxfC9Cgl
         C8+5FjbkK661w2xwzzmQ4ryrepXFv2iiB0eDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3RKDUpLHSH4OD7mBSrVtKOYMv8CoVoHckaHZEsIkq4=;
        b=KOoKfL9KXw/F+7KW1diS9Jr12qxxWDMSZo/4JgMAVapqBzfJW0f7PcsTw//FfwPVYu
         MEg92t/MAFxCZGKY5Re9tVlsTtgWvxH1DVE3+VBrmBhucz7J/53CDIr6vQsAY+WzIYUw
         FqV5tzpsKUSs960Exn5F66O101FOXwLnKaszyajWh0iNE2fGMVgXojJ1f/YaTeyoLSH0
         PM/oMgGNCX23v7R1Uzk8cwEx/nGDNsafz1YwPKXGdSlzfcMykZslxl6DC7gaVWPln2m4
         NhzUXcHvzoUMlp2kLG8B3GcDujaF39Y6BcH5DaTr3dJCVT65gD5O/+CtLIOHpcFsUNA4
         IHsQ==
X-Gm-Message-State: AFqh2krvZtEhYhwXhkuWqeqR3Mx9oYGOlMuWqVHIHdr+nNmA+sLJIeqv
        7ny5IdXaNX3UutblZ+2X5UyKOOb2NQTdF1+n62lAtQ==
X-Google-Smtp-Source: AMrXdXuVE8jGRrwpzSJm50GAFPDPk2bw9DQY1t+35libp4KRqkIN4hZjSpcDlB+30nyy4CFNbmyjNEg/4CYw0MfHtJM=
X-Received: by 2002:a05:690c:589:b0:4b4:f4a7:3ac5 with SMTP id
 bo9-20020a05690c058900b004b4f4a73ac5mr685186ywb.187.1672893640435; Wed, 04
 Jan 2023 20:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20230104011524.369764-1-robbarnes@google.com> <20230104011524.369764-2-robbarnes@google.com>
In-Reply-To: <20230104011524.369764-2-robbarnes@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 4 Jan 2023 20:40:28 -0800
Message-ID: <CACeCKaeS=q2PMtLPivqVLAUNho99KOkD7qsrxorXd8LPRerY8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/chrome: cros_ec: Poll EC log on EC panic
To:     Rob Barnes <robbarnes@google.com>
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, dtor@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 5:15 PM Rob Barnes <robbarnes@google.com> wrote:
>
> Add handler for CrOS EC panic events. When a panic is reported,
> immediately poll for EC log.
>
> This should result in the log leading to the EC panic being
> preserved.
>
> ACPI_NOTIFY_CROS_EC_PANIC is defined in coreboot at
> https://review.coreboot.org/plugins/gitiles/coreboot/+/refs/heads/master/src/ec/google/chromeec/acpi/ec.asl
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>
FWIW:
Reviewed-by: Prashant Malani <pmalani@chromium.org>
