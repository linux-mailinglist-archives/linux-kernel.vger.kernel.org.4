Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4696D277D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjCaSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:04:40 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACFE393;
        Fri, 31 Mar 2023 11:04:40 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso12275374otb.12;
        Fri, 31 Mar 2023 11:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OfUKZ8f2abaxXoD2WwniaK+VMGx278wFzXMC0ygxEQ=;
        b=O2D69BBqmtK0TzXFG4N/sa9LV1rXmlgHF/mZx1928p8vUSeJ0VY1FqcxN/Eh/gTHGi
         jd5VSkFVKs+d3ORqnZL7fOvJcdeEKmqDKr/ceqmS9ebtBjcJCNlFyWbbzEnJ0x/3uQNp
         T8llyy7rZSB2JaPsAG7l7I9KtC0r9oQKZiSWMDhq4pH9yI59twY9IIdBuVpz9vt/YCVE
         RMw0ZtjDkfaapOwdYbJXbbwA7HxiOCB4WYl7bo5fCZmODYH5vT0XV1ADN+zkSQvUcqm5
         Y9O1AQMQIPTsZ2/BeRKTkVbQ1EAubXMXnNg5JrAxiGUNDFHEB6uq7Y9FFYARg6Osu6IV
         T/lg==
X-Gm-Message-State: AO0yUKU5/dzR/vHRSH4Tr+0sTlCLqx6kvHJ7m4Dpuxb5MnE/8ZZp5yb3
        VUKJ01XtKhQk9tefyiS/mw==
X-Google-Smtp-Source: AK7set+HVh4qD4jVJxKv1wPFRKzEuL5X7/z6zM+rjDs9/MBWSk/RReSx5BuXXsfsMHyxpmVWhbptvA==
X-Received: by 2002:a05:6830:3a1a:b0:69f:166a:ae60 with SMTP id di26-20020a0568303a1a00b0069f166aae60mr12768958otb.28.1680285879376;
        Fri, 31 Mar 2023 11:04:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f16-20020a9d5f10000000b006a17328e3e7sm1405900oti.42.2023.03.31.11.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:04:39 -0700 (PDT)
Received: (nullmailer pid 1762548 invoked by uid 1000);
        Fri, 31 Mar 2023 18:04:38 -0000
Date:   Fri, 31 Mar 2023 13:04:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
Message-ID: <20230331180438.GA1715677-robh@kernel.org>
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317053415.2254616-2-frowand.list@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> When enabling CONFIG_OF on a platform where of_root is not populated by
> firmware, we end up without a root node. In order to apply overlays and
> create subnodes of the root node, we need one. Create this root node
> by unflattening an empty builtin dtb.
> 
> If firmware provides a flattened device tree (FDT) then the FDT is
> unflattened via setup_arch().  Otherwise setup_of(), which is called
> immediately after setup_arch(), will create the default root node
> if it does not exist.

I thought of another way to handle this. Every arch except IIRC sparc, 
s390, and ia64 calls unflatten(_and_copy)?_device_tree already. At 
least any arch anyone is going to care about for this stuff does. It's 
just conditional in some cases. So why not make the existing calls 
unconditional?

Either way, I think that of_have_populated_dt() calls will need to be 
checked whether this change.

Rob
