Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8F6CB0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjC0VfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjC0VfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:35:02 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569492121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:35:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i7so12625159ybt.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679952900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EHLi/pEdydeVQSPS8JiUCU4b6C8ijlHrlnkCBX33qU=;
        b=F2CJBXF3tN3ocsEICdrW7raAYzXA4DkY/rbN8hYHJXAvuePg7dJuj7vxEUY8C6thKq
         h/6C2I/X9NL7sf2SqR0/Lgh2pOOXGn15t49+syX0LbjTH9jVOmVC3uxmVrJfmAzwxc9f
         xbdTnrg22udcZa/I2/VcUTMsLsnR+2bblNy1OpSaN/wjDAyrbx+tI/VErjeGACN5V791
         R4gBfZRuGsZcmXjKlSP+lm5k8wwNpmQXV2VpDRGF5FrQqGtzWH6l9bH2rB1gpY49oYSf
         Kk8jXQ4kr92b68FIJMs5bA+ZBNhWVAbEEG4gqcRrafQo7c9j3KjXf6HyrnxzsR7U6rzN
         ytVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EHLi/pEdydeVQSPS8JiUCU4b6C8ijlHrlnkCBX33qU=;
        b=2NSM4AvsKAto6tlJE/pN6oudynBKBUH/h3Umronebsrn0jn+GS42yKKDcEDXss14y9
         h+S2V5WxZvdV2slCv/lhf84EcRvCJt0EyrKNNHvFNhq/JPZcaQDKulrigsccJeTIXpR7
         c+lUmPJqRM4D269HbnEG2uw8hCxNAAtOzitcbo5VRS5p7QJOZ7M1IQK7PWg4IZ5ae2DP
         TikHWJsBmBKxeCkSC+pf5eu78S94E9pjX8bQoyu4peK7rEVp8b6BGNRVKjbpGQdRxMuH
         0bFYxZBJi53ojv48JJxDZ5X+U33oIUv5F6wUqsRCCfEMYrdWJHVkvFPuLEQNrZSbSLMh
         wzwg==
X-Gm-Message-State: AAQBX9emq0S5wLMBmyOE2pFb6u3DPpkOIw+fBwqU2yg9HhC8eU8xxilc
        9GV3osDBQaGCVExSKQAFxARWvQrUFnVGPF2DCSPtUg==
X-Google-Smtp-Source: AKy350buTejEMU08heL381mSiUn8DJI9KfxE2hFsE8fiLlSzZGZOtsKIW4CPuTrSRNqaunMTwdabOeP+3ibsmmEKuLc=
X-Received: by 2002:a05:6902:120c:b0:b74:77fa:581d with SMTP id
 s12-20020a056902120c00b00b7477fa581dmr6463549ybu.4.1679952900593; Mon, 27 Mar
 2023 14:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230327062754.3326-1-clin@suse.com> <20230327062754.3326-2-clin@suse.com>
In-Reply-To: <20230327062754.3326-2-clin@suse.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Mar 2023 23:34:49 +0200
Message-ID: <CACRpkda0yLif_4vgeM74Y8M6GC2je=9eGH0rWnvRQCrPp5dNkw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] pinctrl: s32: refine error/return/config checks
 and simplify driver codes
To:     Chester Lin <clin@suse.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 8:28=E2=80=AFAM Chester Lin <clin@suse.com> wrote:

> Improve error/return code handlings and config checks in order to have
> better reliability and simplify driver codes such as removing/changing
> improper macros, blanks, print formats and helper calls.
>
> Signed-off-by: Chester Lin <clin@suse.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied!

Yours,
Linus Walleij
