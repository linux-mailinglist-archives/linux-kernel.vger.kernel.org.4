Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA670D6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjEWIGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjEWIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:06:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5018B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:06:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3093a6311dcso6967233f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684829143; x=1687421143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql57Z2nlxyXEVXNlg6mwxpiQmGi/AEaE7UqVHsB0qqM=;
        b=AcTHjIL2uJ+i6ehzSI/CpqEP9XumuQEYjaIZpKXxsUG+q4rbcZuf+y82WZnoJwyl7a
         xttnbXZnADeBnqTbDCGBYuPiAOuddMfZaxLsXa+fTYbAop/X7UpI7ro8e1SOat2ft9ju
         2KJRYY+YVs3kKewRb7w85c4I9y1k4a90Ii2qm0v9wTFfSAHXUFAHLdECBv67UY9n0tNZ
         ziYMjCooi1dHpEueVMGz2P52Lqoso2rFlMVC9wqJcRo05c8rfCYYOiXqy8nFZHyUmbCf
         +i85LeT0nVi6BI9kAOzIieksI7Hr95VQnxclIf6q5fJkCiKq8G22XLxsK7QpDA11FVRO
         njZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829143; x=1687421143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql57Z2nlxyXEVXNlg6mwxpiQmGi/AEaE7UqVHsB0qqM=;
        b=mAWQu+M/KUX3R+NRH0/FDIF4ywxkzN2ZHQODDmtlwbpnlTEM7kezoj7DHbK4NrZdgT
         EptDEJHDxAX2x+5R+CCq1RtCNxF7+xQoQFXjTPrngGmbMFk5gmwfbdsfwdjRtQRyvamH
         4tAzOyMg2HPW7eUOgfClOHcATlQGLfRLHP8gNvOWDilh0dWjanHyQ6AYgsjWvrDFrWBO
         mv4TtPBmtVG2w+dIPQcudhGAu37FqaBVyNFoG6bw3/4Uh7r3rWfaPT/z683w4abZwhxO
         mlQpjkDwE8GncBRrxoQjrvbWvkVCnt3Zb8vyOX/h5tGJF98fcYWrZptBpIbBiaERno28
         /4Mg==
X-Gm-Message-State: AC+VfDyHaMwI9UZxNKRBB7AjvRHQsl27aRUMv8WWu+vS8pmN7VNU9gjJ
        PQyC3RRs/IL5k8qFKEh8L4LlVg==
X-Google-Smtp-Source: ACHHUZ5EKZ8vJOklyzHxj7T+ArVP3ODSKBJJQZKdnpztxWowsEWFgd8C12bRuW7+E2oWjAW352+yvQ==
X-Received: by 2002:a5d:4b89:0:b0:307:8879:6cc1 with SMTP id b9-20020a5d4b89000000b0030788796cc1mr8580131wrt.71.1684829143528;
        Tue, 23 May 2023 01:05:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000104d00b0030632833e74sm10211181wrx.11.2023.05.23.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:05:42 -0700 (PDT)
Date:   Tue, 23 May 2023 11:05:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: keystone: Free IRQ in `ks_pcie_remove` and the
 error handling section of `ks_pcie_probe`
Message-ID: <07527dce-8918-4537-8876-086f73718fa0@kili.mountain>
References: <20230516051659.22194-1-xyzeng@stu.xidian.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516051659.22194-1-xyzeng@stu.xidian.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heh.  Presumably you sent this by mistake.  (Xiangyi Zeng sent a
completely different version to the HUST list a few moments ago).

regards,
dan carpenter

