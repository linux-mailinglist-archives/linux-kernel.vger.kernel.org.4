Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E916509A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiLSJ4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiLSJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:56:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFEDF90;
        Mon, 19 Dec 2022 01:56:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so8399987wma.1;
        Mon, 19 Dec 2022 01:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1TlFpfwh1cUd7lasdS0TJdXaV+NBpfvZMgaG1RnRCc=;
        b=BWm/sIHRswTmWEZZLPp1W/fvUnN3b157Lrxe7mS/VkGevKdiAp/ElMDCQFflTVJtVw
         haw1JXcwoSIpmuPocTFyV/eFF5N4ZEjqOHHdrWjMe0npZLDikDLegNc8XTge/zq6OKMq
         Kpp7muFroZJ/eHZPQhKA5poV+q74PwCfrU7wyxUlL66oEYfLxrP4WlvdeXEYln3ifRPt
         QLKsQEycw8LjslWncqAFQCyPQufYfl+a8s60HQ8HYhMN4NOowXUmu1AwymzkgU/6bCSj
         gWMotaBbq4HFRSL+dBcI6qJc4+2JpFeNwD63E0tikhJVnL2hUItkU8oDlE5CkTjS2NH0
         JxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1TlFpfwh1cUd7lasdS0TJdXaV+NBpfvZMgaG1RnRCc=;
        b=olbQWPCwO12ri+qzLxfyZMDnaOpwM10nEbOvFoebmSGyeeSI3B+84sF8/gNtUMo2mI
         cJsrpQ7nmHpDHL2NCPZoCt5s9l7rn6onxFiPzULMvP6c6vE2P1Ed5RLVwYDLhaCiJ+UK
         fw+SNDH6bJInzHW/5bdAi5dVA/giNrVEzDc3Ril1PEigdL9RVAyi8kmqVPd3CZbQi0vo
         1GifN8vJcSOc+XaIxBf1NJMu82CvZLv94C70cAuIy/Ga1+81v0FrYNVnJv4XDU7Np9FC
         RPupsunKM49j6wKO1Nu1i0EBdUnNZl8mYQLftD1iQkJkRYInuin2uAHkmXwx9SqsC9KU
         b3xQ==
X-Gm-Message-State: AFqh2kq3GKAxeXFxCjeUpmGGz3vzozpTMLryQ2vMysWBX7UJiWgIQBhI
        Hd6KhtAGl0D0mk+QO7vLqgMM0dAlTmpsSA==
X-Google-Smtp-Source: AMrXdXv74oUVOrYWxuoZI16hN522voe8GCvlJaUisrJbX64uo9dZdf5inm1MOJ4rTcsMoXF5dlc7dg==
X-Received: by 2002:a05:600c:54ed:b0:3d3:3c74:dbd0 with SMTP id jb13-20020a05600c54ed00b003d33c74dbd0mr10736723wmb.13.1671443796444;
        Mon, 19 Dec 2022 01:56:36 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id z19-20020a05600c221300b003a3170a7af9sm11674608wml.4.2022.12.19.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:56:36 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     inochiama@outlook.com
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: uclogic: Add support for recent Huion tablets
Date:   Mon, 19 Dec 2022 10:56:22 +0100
Message-Id: <20221219095622.255134-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <PH7PR20MB49624FFCDF1F9382886933D3BB1E9@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624FFCDF1F9382886933D3BB1E9@PH7PR20MB4962.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Inochi and thanks for the patch!

> Since Huion uses a new device id for recent tablets, add a new
> device id 0x0064 to support recent Huion tablets.
> 
> At least these tablets are using device id 0x0064:
> 
> Gaomon 1060 Pro (0x256c:0x0064)
> Gaomon M6       (0x256c:0x0064)
> Huion KD200     (0x256c:0x0064)
> Huion KD100     (0x256c:0x0064)
> 
> This patch was tested on Gaomon 1060 Pro and Huion KD200. This patch
> may affect other models with the same id, however, it's seems that the
> other models of Huion do not have incompatible hardware changes, so
> this patch should still work.

While this patch is correct, HUION always reuse the same vendor/product 
IDs, meaning that it'll affect a fairly big number of devices.

Checking some comments in DIGImend's issue tracker [1], users report
that their tablet works applying a similar patch. However, I think that 
it could be a good idea if you could build a version of the driver
including your patch and request them to test it.

I'm pretty sure it'll work, but it might be a good idea to test it on
more devices before merging it.

Best wishes,
Jose

[1] https://github.com/DIGImend/digimend-kernel-drivers/issues?q=0064

