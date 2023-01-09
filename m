Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA106629C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjAIPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjAIPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:18:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A132D;
        Mon,  9 Jan 2023 07:18:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0066118F;
        Mon,  9 Jan 2023 15:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53CFC433EF;
        Mon,  9 Jan 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673277504;
        bh=VoylUKB7KAYjI4lL3TSlxJQLlRd4PyTwQaGlgfA/DY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=So1ahHLTI2eUVOFZ4EDGcN1PG4A7gKafxwRPkrGQPA4DtaHIfcFLO5B/kPXwOuCQO
         OAxLK9ggU780vNJWdfmyQ5sB0tFoof8M7eVGC9QHasamgVwhFlU138IBQ0bKpHksZj
         Y/xRGLmdwdf8BB8BN8OwlLGCNVz7M9JhBdIzYTPAhjvzbNFKUZ/W+OcoDFgLbdwPLd
         gLUmN0ppSKJFXaKAPZZBwuL2Jtg7wOm01Wyw/rSe1NpEybxYD757dIi9wJ40HhWZlT
         GV5vvobXiziKnipDgmAsYqpmQhYVn04FwF6INf+FDPLZcwaozfLGlMcm6DipsP6At3
         HqHr/OJQDJ4wA==
Date:   Tue, 10 Jan 2023 00:18:20 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from
 32 KB to 256 KB for DCC support
Message-Id: <20230110001820.5ca81344286f614ed4ccec77@kernel.org>
In-Reply-To: <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
        <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 20:01:05 +0530
Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:

> Increasing the memory size of bootconfig to be able to handle a max number of
> 8192 nodes to be fitted in memory size of 256KB.

Sorry, but you missed the 'xbc_node::data' stores the index of the data and
that is uint16_t. So the XBC_DATA_MAX is fixed limitation.

The number of nodes (XBC_NODE_MAX) can be expanded because I just decided it
to keep the pre-compiled array size ~8KB. Maybe expanding it to 64KB just
increase the size of kernel on init memory (and freed after boot).

Could you tell me why you need such a big data for your DCC?

Thank you,

> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  include/linux/bootconfig.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 1611f9d..64d233b 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -55,11 +55,11 @@ struct xbc_node {
>  } __attribute__ ((__packed__));
>  
>  #define XBC_KEY		0
> -#define XBC_VALUE	(1 << 15)
> -/* Maximum size of boot config is 32KB - 1 */
> +#define XBC_VALUE	(1 << 18)
> +/* Maximum size of boot config is 256KB - 1 */
>  #define XBC_DATA_MAX	(XBC_VALUE - 1)
>  
> -#define XBC_NODE_MAX	1024
> +#define XBC_NODE_MAX	8192
>  #define XBC_KEYLEN_MAX	256
>  #define XBC_DEPTH_MAX	16
>  
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
