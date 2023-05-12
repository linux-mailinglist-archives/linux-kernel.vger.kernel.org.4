Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62E96FFE30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbjELAzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142714C1F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE99560FBA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5497BC433EF;
        Fri, 12 May 2023 00:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683852944;
        bh=hqORGTuFn34NPCgboOJIrkMoupu4sFw407EbC5EaQvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P/t7XsQE6C2iwFL92q8S3BwoVjW/bpJnxJCbKUDm2psz+EnRaR4ottamzangYgV/4
         aPJ4t+q4Fcn1Yy14q0EIgVFR+oUi29GoGRi+1kyV6wtOwZjSzKLjFXUy4kqnvfjc/S
         QTfSBbRnB+gURKB2jYfLk89h/Qo2IezfOeoR+BGFOaG8/mjUR/42cJQKVTPycgM9QN
         i7FfiTcCPg78v4jt4jkEJQt4Hwg0v7qzXTOSVsv54dta73VaWjTrCEAcsWoWpzMhcg
         6D3fsoADyRMYrNTrsmGyBvoYCMHDT0i9ts5+8x45oy60fJfv/PVG818ZTuVBy0x6nM
         CiGcHh+cRj/6A==
Date:   Thu, 11 May 2023 17:55:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Wei Fang <wei.fang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH v2 net 1/1] net: fec: using the standard return codes
 when xdp xmit errors
Message-ID: <20230511175542.0bf5b773@kernel.org>
In-Reply-To: <20230510200523.1352951-1-shenwei.wang@nxp.com>
References: <20230510200523.1352951-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 15:05:23 -0500 Shenwei Wang wrote:
> -		xdp_return_frame(frame);

This line is a bug fix (double free).

I'm going to apply v2, it's good enough.
