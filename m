Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70020691077
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBISjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBISjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:39:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746B16590;
        Thu,  9 Feb 2023 10:39:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b5so3854740plz.5;
        Thu, 09 Feb 2023 10:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXrxNJPo4710vQXfLlUqnKiFqVdmV4GK7KJqHS2H9NA=;
        b=ZSzYUSL+OaZ/dcA3qRT4wBFw3528/581THPDhVKDzi/JypnlDtTO/9WjzuL/SlvRu0
         CGPtQRp1VI2R0lavWI3q3+csWqMgovF4e544eX8ag2PEXQZe6tjOOWjbQJloevPLNZAH
         dXmEXmcQ74ZuUCPgCdOLcweb92Raoq2uZ8mA+gF0OibcsZUqzbXeLHaFH4rBDs4vcCsI
         rU1Np0oo4swoES613OTmuO5Ki305GGaCqUfrWM/4pEXa//r0Q8lVYijLG9MzC76NTdfO
         vaFOjPNohhywx42mLoVdr7lI1TQ0FxmVnEeODU5YHGsx+8TDhbze5RWPh0Uv+KC/P7mJ
         nMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXrxNJPo4710vQXfLlUqnKiFqVdmV4GK7KJqHS2H9NA=;
        b=rX5dRDAsrhfW5iDwvF7oBEF5707odDR16s0DA3cYJSqxPnUBKzEvDmR+A0IxatfYQG
         cCwTbniU65tTOSUZULKbDhyPv3IKFrlf6kC0SU5PclxVpdVz34v6zkpuyTmEbpi82vK5
         1EtpP3jH7RdjlCmXaiEjfB86UY2tsnZfl6221DboMHuB4CuLKdErTiXWOKzaawvcTdox
         lyO/m96ar7Q1Y/LFobjwkFqZBIuW0E5ydqdrP40wspjNQJQnL5trcCzXk6k/8QSt+o1N
         saKHBpAbbxXh2wMnFuiv3ZNGx4zuHwjD9T+85KaDsro1/grf2A5zigB7YaVvbahbJZCO
         dPcA==
X-Gm-Message-State: AO0yUKVTJzYFqKP5LS0sEV61Rnbf2bprPr+a1RZHSPyf8g6Ofx+kAnlY
        f+XlLz6XGyZ+ishHMTvilKNBCh78deo+NQ==
X-Google-Smtp-Source: AK7set+KaXa4HvuatK30HE/98Z4oxO2W2R6X52b3BN6yHMAmMzCCHP5RiClDNS/WVP1AcwsRmx2jfA==
X-Received: by 2002:a05:6a21:164b:b0:bc:f665:8653 with SMTP id no11-20020a056a21164b00b000bcf6658653mr9298603pzb.45.1675967957890;
        Thu, 09 Feb 2023 10:39:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 2-20020aa79142000000b00575caf80d08sm1790144pfi.31.2023.02.09.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:39:17 -0800 (PST)
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
Subject: Re: [PATCH v3 04/15] arm64: dts: broadcom: bcmbca: Add spi controller node
Date:   Thu,  9 Feb 2023 10:39:15 -0800
Message-Id: <20230209183915.2317171-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207065826.285013-5-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com> <20230207065826.285013-5-william.zhang@broadcom.com>
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

On Mon,  6 Feb 2023 22:58:15 -0800, William Zhang <william.zhang@broadcom.com> wrote:
> Add support for HSSPI controller in ARMv8 chip dts files.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
