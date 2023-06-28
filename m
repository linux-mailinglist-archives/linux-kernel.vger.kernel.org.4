Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222897410C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjF1MLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjF1MKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:10:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB2198A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:10:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5109255f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687954248; x=1690546248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNzB1WpMZkYHFT1Ymey/wXVFErPYLjpbwzItBx8g8ps=;
        b=KWn/piM7sH8n7Fq8pw8OnNwcYokHOXXe/L1owHFcd9xafCcYJjFIGBTtzUaOGSCoAR
         yGy129zi/AnU735nCu1YFGD1j1p28cKKf5njzUs69iRN60DzlzlX8CvclNLFRBvdMJ1w
         biLpqpHk+o5q/9Ps2+9BTuMUhIJv5Q2Ydwa1rCDX4PTcG18Hn7V3Ni392bBcHGzF6Ea2
         HtLbn1KhFm00bXLriPYxPdvGUgy2SmcujrRvhLCwjTK7rRnvkVXzKM13yrh/qjvwNjo9
         si3GrJ0EoX7ZnRqsD3XzBkF7347g5u7AFI1jzLlwBec7SHUUS6GUboBfdF6jzMvow30Z
         +0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687954248; x=1690546248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNzB1WpMZkYHFT1Ymey/wXVFErPYLjpbwzItBx8g8ps=;
        b=AALHyU63FbXcnlMpMGkUbIG0fbb7Uc5LWBm1zQyK7eYTwp/EroFgc7tO/tE6Lw4fQx
         i9Z9riABRiZwtcr/cFptjRURFtokMNDtcB0s10RLP40Hppk1c4iQJhCBoxJ5qPw8/uCr
         0so1KWnAteVU+VQSMm3/QO+QRzQbDPs9B3Zp1PozaSZUHCukxRoVevtlz1NR1BqsWrrb
         tSelbowuCzuN9KrUtQwsobM/RXhChsJwCbyHmNTVR/ZeRLKlLKtqgdLKtZ7DL/sjm91m
         uu/6j82UY8b3bDpjY17D88XUhKoxsUqyHf+N3pHHPS5ZSP2VZ1bXxI9bzPJCqcrJhIfG
         zUoQ==
X-Gm-Message-State: AC+VfDxRDKOCPs9UgvpHilpWX/sSJNs5VaAcqw4wW8xYKtCeZtoYIP1z
        UmTmwpus6G8ZIVoSicudMb/EhXzoVtwnAVf3t+U=
X-Google-Smtp-Source: ACHHUZ77T9pGiPpJduBf3/u1tI9M1+qRpxcDBusJCKksWCJ5p+RZW0pmaaRqa5jAFB6TnepuZU98Ev61VN+og6bbXWA=
X-Received: by 2002:adf:e810:0:b0:313:f846:c200 with SMTP id
 o16-20020adfe810000000b00313f846c200mr4768646wrm.15.1687954248135; Wed, 28
 Jun 2023 05:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230628112958.45374-1-dg573847474@gmail.com> <2023062838-precut-hacker-40bd@gregkh>
In-Reply-To: <2023062838-precut-hacker-40bd@gregkh>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 28 Jun 2023 20:10:36 +0800
Message-ID: <CAAo+4rXrrtRUX6nPWO_gRYaw-nm=ZPme6JWwTZeuh3vTR_Xx-w@mail.gmail.com>
Subject: Re: [PATCH v2] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honestly it is not tested dynamically, I only manually check the code
and send those issues I think are more likely to be true and show it
via the patch.

Just let me know If you plan to fix it and I am willing to help with new
patch version.

Best Regards,
Chengfeng
