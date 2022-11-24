Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395506377E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKXLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKXLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:47:17 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEADAEBF3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:47:16 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l2so880116qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SgUK8+C+P84jnn4mPFsvd+MDz8e0Zg/WY7xfiup5DA=;
        b=4M0mnp20F24FRahiYaJ82l4gm6RfSBmCpRU6BnbrYq+suNgie3rrWTOP9t3Hz06wdq
         8JuZpvNwf+mEp+N11n21A9wexXOf2Q/zqQEKRl6IBbAXBVrbvhIY0xybi6kuMGVgrOGG
         WesrgNT6wsqt/yHaUTH1D5zRMHxpfduYcvELm49lfsOOqHq8MW/bCjz9PYJrvbmrRm2g
         jjC41Qgo42fGVoxS/FIUSxG/QlLuT9nqcPip8ewKXTB7FhgyG3/BN4dlEB3sc2LHDU2f
         DzgtNY5TSyFsX9hpgDOxYJFpkc7IOQteQJDtshzH8Bo0fqxig3IwFwSLFvKb6BwGsMyk
         /PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SgUK8+C+P84jnn4mPFsvd+MDz8e0Zg/WY7xfiup5DA=;
        b=wYRPe6VYcbwtcXMrj2EKMp+qoCfCBFknPiXczPTX80kLtrX8dERzthoDWfUXk4tPe5
         VgTP9I6xerciYoNzuj511jIpb9mE54HS+rCfOd/hejU7ntmoMbS9XOlg1mHzjROdseZg
         fycvsB1vDKdRH/lBLS0L7iYe1hyN5CjOgc+gErQlg/kr4C/KEYiH3gReA4nv8GhUbN3v
         mGqRPYRQhgLPECU9bHSD13yIiwPIrQcdKQhr+eCKrMTXQ3mHn+yyqquO6b4Aj0HD4PgA
         tWlSxntx6LOHYSpUeg0u+qcojMsFvihG1UEroNFrq49qiwzMvX0f5Wa5oKy5hGF16ir9
         qJQA==
X-Gm-Message-State: ANoB5pmB3vATevFxrKc//Ql+sKouS5ZCRMZXKZx9Dt+owxiGvLmI0O4x
        6UZYgHle+OF2q72ZGAvht4e4aRw/+EReTx2K
X-Google-Smtp-Source: AA0mqf4M6w6V8t3BsLfx3krwufUht6waa3tlVU6wdp5SKBKVv7RsMfoHiwFX2f0ypN1pXQZwyIk5Xg==
X-Received: by 2002:ac8:4e37:0:b0:3a4:f140:f707 with SMTP id d23-20020ac84e37000000b003a4f140f707mr16043854qtw.317.1669290435194;
        Thu, 24 Nov 2022 03:47:15 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id bq10-20020a05622a1c0a00b003a582090530sm454146qtb.83.2022.11.24.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:47:14 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
To:     michael@walle.cc
Cc:     greg.malysa@timesys.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        nathan.morrison@timesys.com, pratyush@kernel.org, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: RE: [PATCH 0/2] These are the required patches I found while adding
Date:   Thu, 24 Nov 2022 06:47:13 -0500
Message-Id: <20221124114713.132514-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bb6c006a27184ffa0e4ab9303cffcc72@walle.cc>
References: <bb6c006a27184ffa0e4ab9303cffcc72@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Ah yes, I just realized we're effectively using the device in 1S-1S-8S extended SPI mode, so the 0xC7 setting is probably not required.  We were never able to get DTR mode working on the IS25LX256.  I can fix this patch up so it's more explicit about what's going on here.

The 8S-8S-8S support in core.c is still going to be used for another OSPI device I'm porting over from an older kernel.

Would you like me to separate these patches, fix up the ISSI once, and resubmit?

Sincerely,
Nathan
