Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8EB64346B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiLETq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiLETqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:46:05 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C52DA98;
        Mon,  5 Dec 2022 11:42:26 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so14723838fac.2;
        Mon, 05 Dec 2022 11:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwtUnWRhcXi3vHuwS7fJ1x5P4unvbDZKnLOAXO8tzqQ=;
        b=vytJSjguo358gTWWGPgDDnGu0VuHKmjk21EabO/bSI/k+9ACMIwkFq+9TfNZHG5Lve
         et/1ZopXwvTJXVk4N4OvIaSu/n2b/58+8Vg3c/Qsm55AOGTowubAnVxUyqKMcuiJV4m7
         7I6iuMVb7lMs5uVOxBniOEXvNOCtgXrdGch4WfGemMhbyHzb+HyMh4tOoYACjetyfCz2
         Odq99hQlP50Q7YAi8Jj8vPuf2bcNga7ZjCvMnuDi0dWrbZCr7ciB/nlPrK4/PFSYuhjM
         G2hk4GIsJxtQWz+XHyKu6yn7L/li9vlFLQKrVaLC1fHjxjC+qq2QSL/2/PT6jeR9q7hR
         nD2w==
X-Gm-Message-State: ANoB5plIEUrgXEwk+L+qUKbll5bg9Om9dhzPaQMNw1jZuJyaKNy3pSJu
        O9yJYMY1ChcuuekUP+JDBA==
X-Google-Smtp-Source: AA0mqf7mIsgmwqlw8/wmvAHtTjOWt43bx7CJhpx5R1PKP7Ypb/aP8Ye3Bws7U3SFMAb8D4rKuV/myA==
X-Received: by 2002:a05:6870:6c1b:b0:144:307b:c88a with SMTP id na27-20020a0568706c1b00b00144307bc88amr10087441oab.267.1670269345827;
        Mon, 05 Dec 2022 11:42:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o12-20020a4abe8c000000b0049f3f5afcbasm906400oop.13.2022.12.05.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:42:25 -0800 (PST)
Received: (nullmailer pid 2470894 invoked by uid 1000);
        Mon, 05 Dec 2022 19:42:24 -0000
Date:   Mon, 5 Dec 2022 13:42:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-acpi@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>
Subject: Re: [PATCH v7 02/20] dt-bindings: Add binding for gunyah hypervisor
Message-ID: <167026934327.2470835.18397895386816332012.robh@kernel.org>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
 <20221121140009.2353512-3-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121140009.2353512-3-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Nov 2022 05:59:51 -0800, Elliot Berman wrote:
> When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah
> Resource Manager applies a devicetree overlay describing the virtual
> platform configuration of the guest VM, such as the message queue
> capability IDs for communicating with the Resource Manager. This
> information is not otherwise discoverable by a VM: the Gunyah hypervisor
> core does not provide a direct interface to discover capability IDs nor
> a way to communicate with RM without having already known the
> corresponding message queue capability ID. Add the DT bindings that
> Gunyah adheres for the hypervisor node and message queues.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../bindings/firmware/gunyah-hypervisor.yaml  | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
