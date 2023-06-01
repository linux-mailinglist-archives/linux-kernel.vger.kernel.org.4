Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E271A12C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjFAO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjFAO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:57:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F7189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:57:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51452556acdso477034a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631460; x=1688223460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cLaDMhf+OF404gT5xrdkaYTu7FOMzJ/h0JxLAu5gx8=;
        b=paO6O0P+7/GfE1jJwzk8aDHHIZhS0NQqlUIPLrnBS9nVujMxur0Vjhw7kwl5GAEBfa
         wbmDOfyzTEVruK31Bcz2J8jYh6dfRmtmZfxmOwJaFgESA+A77WE10nzgFvbQ9+AEiTGj
         S5WOEqbQYHGqTiqyfo3T8oGJpn4v8ERMlGJ3QV9giF5Bk+BgOvJzYRN+D75B0SImTru+
         T6Tbd2qfMzhazFEMA+8auc58ofCyv0ZbtSBhqmUPirJwil/2/nzg6hbW6tm7kgmx9lqk
         WAXboEMY3mI6Twu088as7Nn7d8Rg5xPX25Fwm85S/87RN8+WH6+sTKecpZdl5rU88V8Y
         2x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631460; x=1688223460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cLaDMhf+OF404gT5xrdkaYTu7FOMzJ/h0JxLAu5gx8=;
        b=f3bRQYg4Q80T5NHQXshV7vO3H3jvjprFoR2xVzxDMz8BuaDJsMhIB4CDKBwGp9SEca
         skdOFHqbYonvmMjy/uh8Un+XpzMpDMEHndX7b/+y9ip7xT4cN5ghcrJzT5AkJImbgahL
         Yv8hh+yX0pAyIYmgH2PdfYhBjVjnAIFYBAuwxK+iGSvRFBRjr93SgTk8Hx22RG5+zPGg
         rgN8rinIcblcofIdSlely52dTxC7mhRn4DyixpwtgHfwbbdn9LtAT+o5AWz/zdEY11Is
         3TLO/lp/rz+X17PqgmIkffx3YVQP47LSm3TbfzlaSHCToClBz0+s3iAPlmblFb0xoAI6
         VL0g==
X-Gm-Message-State: AC+VfDwqi5gm+FVJJXK9hlgyBCtUeQiFfIeq62eOyqE/hmK1Zh9UNbNd
        6PAU/Cjz2KePt7G67EQAZb08
X-Google-Smtp-Source: ACHHUZ7iAy6vlvTlsELq6Yie1SToVmkx0Ug6XG0sLdvlvQjr6GpKkm2oHR/HMtnZTOgx0iPuW9AcfA==
X-Received: by 2002:a17:902:e5c9:b0:1ac:3780:3a76 with SMTP id u9-20020a170902e5c900b001ac37803a76mr7450817plf.4.1685631460672;
        Thu, 01 Jun 2023 07:57:40 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:57:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v5 1/9] MAINTAINERS: Add entry for MHI networking drivers under MHI bus
Date:   Thu,  1 Jun 2023 20:27:10 +0530
Message-Id: <20230601145718.12204-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host MHI net driver was not listed earlier. So let's add both host and
endpoint MHI net drivers under MHI bus.

Cc: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..07625a47cf08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13629,6 +13629,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
 F:	Documentation/ABI/stable/sysfs-bus-mhi
 F:	Documentation/mhi/
 F:	drivers/bus/mhi/
+F:	drivers/net/mhi_*
 F:	include/linux/mhi.h
 
 MICROBLAZE ARCHITECTURE
-- 
2.25.1

