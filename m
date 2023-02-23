Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CDD6A0D44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjBWPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:45:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228EC55C02
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:45:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r7so10860573wrz.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUtJHy11n8Y/rq9v+tVThHOQuEU8nOltQBq6+LKXmIk=;
        b=V1VQBLeFVTmxch5HEcztI6KEJGkyu1+nRlw56ftIe1im+aJWKgbqYdAczH9MK4nC2m
         VRJKqGb1sNoAUU8J+HpwV/DWY162iNiiLL77tJDM36JkfzuRBNGbVcIGcu41RN/JpyF7
         b/qNt2HrhUeVDeuRZZkssDz7xlFAjQ197Ip9bQIKM/O+jnUetREpkeJlbtBRPt2Cz1LJ
         lxb8nUSYSBGTb20p4Q0SjRsuITeloeoW3tHqnuL/AnB1guCJZ5shwQQeWDI5VQKyIHlF
         GYaGjPJji34I4D5O5q8mWakY83vQYhaAFtWTJ8yJFnWWBZ4v4ULq0OoA8ipwMjzpn+28
         Gokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUtJHy11n8Y/rq9v+tVThHOQuEU8nOltQBq6+LKXmIk=;
        b=SVjBpjMXhijWvLxJ+M5RTnWybJzpXoryhX71ycx4uSV059DZVoQRuyfVLhQcnxv94o
         FQElidK01P9ClbXb8ILK/BOVhirh4dWRfmP4Nix+qQtcTf+klm5b6H3grvw3/GUd0kFs
         YgTS7QJuLzNBjDrZB+qrKcz3fFpM4iR3RvgYmGtF7npRKu2LFPiUqxra0vNuhQn+b+Ss
         k96nEQwrpnX9ZHB9I3BvXvVyH7vHMR1lMxSqWhNO+zs9yMBBIQqmZdi+0ppsemxjtIxg
         2Wmvcxg/ARWqxKGqh/biOzw0Nt9bmL2BGcg8u9eBENThwuAGD/QsLHEGU4/0/Vn2d3aq
         P+hg==
X-Gm-Message-State: AO0yUKWDnav3wtXl5zuqA6N8qnOQbKb+ZALTm6BrHuCwuQPe/90XWvJF
        CqfJlf99d6KZU59zEjbPO2m1MQ==
X-Google-Smtp-Source: AK7set+vIXFCFewCWF4qBdv5jm6siVTdfVVno5o1udTzlHH2yBZRGnoaUdEWRd1WBIcsio02GMoW9Q==
X-Received: by 2002:a5d:4610:0:b0:2c5:561e:808e with SMTP id t16-20020a5d4610000000b002c5561e808emr13069275wrq.12.1677167119643;
        Thu, 23 Feb 2023 07:45:19 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d4606000000b002c55306f6edsm13876488wrq.54.2023.02.23.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:45:19 -0800 (PST)
Date:   Thu, 23 Feb 2023 15:45:20 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y/eKEMo1moXt3pPP@myrica>
References: <Y+4PmJb2rBGMhS1y@myrica>
 <20230221154624.GA3701506@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221154624.GA3701506@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 09:46:24AM -0600, Bjorn Helgaas wrote:
> It's weird to me that the SMMU is between PCI and memory, but the
> driver seems to insert itself in the middle after PCI enumeration.
> And maybe even after some PCI device driver binding?

No this shouldn't happen, because device drivers expect DMA to be
operational in their probe() function, so at that point the IOMMU must be
configured. The core and IOMMU subsystems enforce probe dependency between
the SMMU and the PCI device, using links described by ACPI or device tree.

Thanks,
Jean
