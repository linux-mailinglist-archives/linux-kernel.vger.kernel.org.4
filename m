Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001F8691070
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBISis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBISiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:38:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C0FC;
        Thu,  9 Feb 2023 10:38:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z1so3845095plg.6;
        Thu, 09 Feb 2023 10:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDOGxqUTvXi38jq+9eyJtBEAlDvxDT1opal4kx5Afsg=;
        b=bGKwWLqV171TFssgDwjN1xTgReNq/VXoxS3bTj9lEE6YBBks7LxnlgO42+Z+orNDTm
         sRS14TKW/mFH4+5Nstk3gsUPj3nnhbXZxvU/Xgzmkqwuty0UjRJnd/lH8SaKYsMCWIio
         FuB5ua2Dira+yqWxmn6XwOqxUH6gFD8HamDbhqhfp6QKSmFfrndoUuBQGByZWyhAkKD9
         HuL2F7e2nbIg6IDJsossLtvfd2Oe5R28A4AZU0b5JjdFYj6uAxma25nW2Z9PhBB/rusk
         +0y6Uj4DImNjnkGAyKNLp2CC4elvUHxF147i8IC0grAzL0XT+Ftp+X81r+NguTdfCm2T
         4pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDOGxqUTvXi38jq+9eyJtBEAlDvxDT1opal4kx5Afsg=;
        b=yLrKyCCd1v3PS2nq2KEIRfv5kfEica1XEOhvOXDWuiAgTy41K91Z5jwt4xYP8fWfch
         xS0EDYMvYoons9O34YYXhxKZduNxus8cv7osxG9PsIHJxTowp3koGDq170qlw5lUcQEy
         WGYgB2Vwaogj+3aVy6VBjE5glYxH+7MU+vYqMiQh7P1qkWMOKnAziYrkToNkJ2oto1cd
         6M3lm2WMh4YaHQ2eV7BazUQ4LiXS692x7ml7gOfZqCEhIeiAlTOwtmFponghOsdwhBSQ
         7sYAogoMZiTdoUfNfuCLHYsGBjOdExuH+fXlY/N+12nCimwmFSWSgc+LNEF3d1KGWnt7
         Be5w==
X-Gm-Message-State: AO0yUKXpDFcQX48/BG8tge8fJ/6U+/pSjlS967lcKqxtvOZSIEK9ezYF
        9W4idFjdpqdJcQvTBaAEb3Y=
X-Google-Smtp-Source: AK7set/0XO36fkWEGacUE7kZnKImh4LpYG2MlUbpXvCDX1Ju5mjwXON2Ggzr9Li3a8SMaM63pBF87Q==
X-Received: by 2002:a17:903:182:b0:199:14a5:405b with SMTP id z2-20020a170903018200b0019914a5405bmr14906706plg.44.1675967924793;
        Thu, 09 Feb 2023 10:38:44 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170903278c00b001990aed8f43sm1850280plb.50.2023.02.09.10.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:38:42 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
Date:   Thu,  9 Feb 2023 10:38:39 -0800
Message-Id: <20230209183839.2316965-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207065826.285013-4-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com> <20230207065826.285013-4-william.zhang@broadcom.com>
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

On Mon,  6 Feb 2023 22:58:14 -0800, William Zhang <william.zhang@broadcom.com> wrote:
> Add support for HSSPI controller in ARMv7 chip dts files.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
