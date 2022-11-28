Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1B763B600
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiK1XhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiK1XhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:37:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598A632BBC;
        Mon, 28 Nov 2022 15:37:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so10194719pjd.5;
        Mon, 28 Nov 2022 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Npu7z/L1GayvIS8JkJy0vVhhh8+ppGvrGmXaMyvlbI=;
        b=e07UFrVnPqGOQ3EPs74CtvdsLTxhc8zPOfSk3wmBumvJqMU4zWBW01VnwgQ7JjDsWr
         QQFmRSQVXxLmnndvNTbOOyHNiXrk+VJYaCLcJRn3TUZnECrkPE54p4RmBdFdOrREFbj4
         sg/vK8gXtM8CWqjfFABxnmh7VpY2oFTcRYvPSvUgxY0T45i/U64RVc5g6D7GnizWJv37
         FaXNktQ+MFhDEWgmQYrOAXYSB5oTKxWSzc83+bJ3cQrGc1XyP6pLAp2CFYv3hcMe2jGz
         hCGOUg/f4uBR96MgQzyXVyEjcOYn1Ly5LPpYG7NLLkM6fOAIn4es45q8WAt7Ojurflat
         TigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Npu7z/L1GayvIS8JkJy0vVhhh8+ppGvrGmXaMyvlbI=;
        b=C4F09tU/xxXyvXFChNpRx8pSjsCMk5zVl1A1MhKJ4UExnogz9xY/7WDex9z0lEFZwv
         1UtOG/lhM8JLNguF03xIHV8hZjE3HkklXl9d0XQx67JENG5JdpWZHxFHz7cbzfyycbWZ
         vg2RC+UZi3IdAs88a6qZkCTlexVygswUGC14Wl5bCGVAnQx6vp3iop5VHVW8YkwMk9fr
         G5R+qIPAnVl8b4bhtpt/G05JYOaDiNc/+TsOTnLNdf+/4ODiqfJHHoSG1C4LkLRYnV4c
         61baKPqqjL6p5yqXEQJoKOiFLJ2eLevPE40qy50UG2TjsPiEDysPHHd0dj/ZnSmb6Uao
         11zA==
X-Gm-Message-State: ANoB5pkHTgwE8eNePizsBiYJwq0Itn7SGufjUIPjanWi2SCBEBhsY7Cl
        52p5J0yrRwQen6A8IeL97O0=
X-Google-Smtp-Source: AA0mqf4496GkrrxTA8Ap6VKgJbV9WFNrg85UltFawmvVxqxVc8cTht/3ZFSI+EHDhuIhEQZ2mkJ7NQ==
X-Received: by 2002:a17:902:c40a:b0:189:884b:96db with SMTP id k10-20020a170902c40a00b00189884b96dbmr8067628plk.9.1669678637763;
        Mon, 28 Nov 2022 15:37:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b00174f61a7d09sm9285973plh.247.2022.11.28.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:37:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] arm: dts: Update cache properties for broadcom
Date:   Mon, 28 Nov 2022 15:37:15 -0800
Message-Id: <20221128233715.501065-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122163208.3810985-2-pierre.gondois@arm.com>
References: <20221122163208.3810985-1-pierre.gondois@arm.com> <20221122163208.3810985-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 17:32:06 +0100, Pierre Gondois <pierre.gondois@arm.com> wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
