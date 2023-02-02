Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F00688B39
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjBBX7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjBBX7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:59:19 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE8728DC;
        Thu,  2 Feb 2023 15:59:18 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id i21-20020a4ad395000000b00517895ed15dso358649oos.0;
        Thu, 02 Feb 2023 15:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHRn6g6VO9qHC/zkbF0I44iV0NS7zFU7u308GKXqOBQ=;
        b=PTpXcCIB+9U61kg6B9FdiEngy5Im2PGRuYEiVnZtFyxBFEVROzhsyho/NkD+fAN6E/
         HnQLYlRcG7dyxDcgABthYhhVggom/E1K0NuKe2Nu+VFCidYMU8/Prm8h59wK85c4jYTn
         YfgBSAHxdymCgaT1Is2Q7UsQtCJp7o/kgU02Ualw4FKQ/eeUWQn0FU7InvKLOfFbw0QI
         izi4En5lZCLpC26W/Amplub8n/CwO6uqn/uPwTZpYtz8MQJEJi5xtoka3Zc8jrjlo+qV
         isG1JBZXjjxtNxD42QO0PQLFHZE4lVnULW1aDpbP1rotPDQ3H/gzYtw/65kmnL1UdmqO
         FTAw==
X-Gm-Message-State: AO0yUKXvP2xskiRodsLSG0PJAEMYiV9+JbTpHuz8TZKHkKdnWixl5F6Q
        ZKcul8JD6oDNYEcdvXFdUqNztllkjg==
X-Google-Smtp-Source: AK7set/EfNNUEXa4onluz3yIFamqI3YXbaMdlrs2eUnpSZwSyN55HuN6Rpb+vqo9LRAKvLhBsIQTVA==
X-Received: by 2002:a4a:988a:0:b0:517:586a:9386 with SMTP id a10-20020a4a988a000000b00517586a9386mr3693920ooj.3.1675382358143;
        Thu, 02 Feb 2023 15:59:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v32-20020a4a9763000000b004f73632d096sm414619ooi.6.2023.02.02.15.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:59:17 -0800 (PST)
Received: (nullmailer pid 2932596 invoked by uid 1000);
        Thu, 02 Feb 2023 23:59:16 -0000
Date:   Thu, 2 Feb 2023 17:59:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net
Subject: Re: [PATCH v5 1/2] dt-bindings: ramoops: Add support to get the
 region dynamically
Message-ID: <20230202235916.GA2931100-robh@kernel.org>
References: <1675330081-15029-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675330081-15029-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 02:58:00PM +0530, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a
> fixed and known location when read from the devicetree. This
> is not desirable in an environment where it is preferred the
> region to be dynamically allocated at runtime, as opposed to
> being fixed at compile time.
> 
> So, update the ramoops binding by using some reserve memory
> property to allocate the ramoops region dynamically.

Sorry, but I still don't think this belongs in DT as I commented on v4.
