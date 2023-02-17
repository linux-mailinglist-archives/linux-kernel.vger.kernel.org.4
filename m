Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36CF69B4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBQVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBQVoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:44:04 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF83B20F;
        Fri, 17 Feb 2023 13:44:04 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id bg20so2072379oib.9;
        Fri, 17 Feb 2023 13:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWC7nngXi0EDz5gN4HHMCNDgyMiC4P5brzXAk68iqjo=;
        b=lGQy4jHtd4fp7TdUTSSiq+DlawvCDsG6dPj1InTdNgQQQwLy8td1DDaeLfIh9PIcCm
         P5DOJh4RQHvE43cne3RBZhlzsRUT+NUcOc7fwWDK3XOtJtTiHS9CGrIUnZ3fIlHtuiOP
         bmAZI4hX5cEztLKNfDpoIg33F2S96rHcXnvzbOiN0hHPv+rMHHyrAVkO14N2xx1hX70D
         CCrtfugiy+dGOI/5v2+29UmC9NpXMGIwARvfa50fBDsYSeHheYlEmefg4yJSihZXxM5D
         MV56pWfTMVUMSvK/an160d3fMJQFqkEquEm9NQ/UN+9SAjOYf3+9ML4gJOZkyy4rPVb8
         BS2A==
X-Gm-Message-State: AO0yUKX9Pz6/AyqggeqDvOzH8ApHlppmqTl0oTcoXOKEhJhH8bLSl1cK
        9GgOkChYo2dT0t56ZVsKvDSK9yXnew==
X-Google-Smtp-Source: AK7set+d69N7zLQXRXR5ATUVWt0hggwD5Fwdthm5UlkIeCoztjD/btqolUFiC3gkRIVmn6wlM/WH1w==
X-Received: by 2002:a05:6808:6392:b0:36e:c24a:a620 with SMTP id ec18-20020a056808639200b0036ec24aa620mr827867oib.1.1676670243244;
        Fri, 17 Feb 2023 13:44:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r204-20020acac1d5000000b0037834b1a20bsm2282871oif.0.2023.02.17.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:44:02 -0800 (PST)
Received: (nullmailer pid 1611422 invoked by uid 1000);
        Fri, 17 Feb 2023 21:44:02 -0000
Date:   Fri, 17 Feb 2023 15:44:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] of: unittest: new node lifecycle tests
Message-ID: <20230217214402.GA1611091-robh@kernel.org>
References: <20230213185702.395776-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213185702.395776-1-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:56:55PM -0600, Frank Rowand wrote:
> Create new devicetree node lifecycle tests.
> 
> The tests introduce use of EXPECT_NOT messages, similar to EXPECT
> messages.  This requires updating scripts/dtc/of_unittest_expect
> to process EXPECT_NOT messages.
> 
> The new tests revealed an issue in printk formatting when using
> format "%pOF" on a node with a reference count of zero.  A patch
> is included to the fix the caller which revealed the issue.
> 
> Update kconfig unittest help to further explain that unittests
> should only be enabled for developer kernels.  Also add info
> about using scripts/dtc/of_unittest_expect to process the output
> of unittests.
> 
> Add an additional consistency check to of_node_release(), which
> is the function that potentially frees node related memory when
> the node's reference count is decremented to zero.
> 
> Add docbook documentation to the devicetree node creation functions
> about caller responsibility to call of_node_put() and how the
> memory free process works.
> 
> Frank Rowand (7):
>   of: prepare to add processing of EXPECT_NOT to of_unittest_expect
>   of: add processing of EXPECT_NOT to of_unittest_expect
>   of: update kconfig unittest help
>   of: unittest: add node lifecycle tests
>   of: do not use "%pOF" printk format on node with refcount of zero
>   of: add consistency check to of_node_release()
>   of: dynamic: add lifecycle docbook info to node creation functions

Series applied.

Rob
