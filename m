Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C964EA3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiLPLX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiLPLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:23:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F525F6;
        Fri, 16 Dec 2022 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7uUzUe05b7rr2RFoVxzKl8oM+JPXRAqmcWlIXshXf6k=; b=aga5oUqtu32MOEtQdA/9l8SgYw
        eqK6h6wN132DVT+oU0J1vAaAqnDD9XVidOHg/mfgKt/l/NNxUEKYmN87y75crq7LwwGSN5uc4Tc28
        LYhn+wq2JNxB9tcorqMrSKjTFx4mLCntL1j2kK16eSjrmZhZ6D/GzC3RXxMXJ3Lwf6Xxtcxrtwzan
        uk7dbMJsjiNaaBQxysHX/awOSdIIxqAIkqaOjc5sgYID/MPPhRVZp+ZjTQ6+wnitR7qIQ0MjkY0eK
        voyqKYu+AJCZBYN91XImzkkURLZtTL+QidKTG6/Ds3aRvOlUVBrICeXyXjIa718NB8LZwntbhghTt
        2g8BSGDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p68o3-00B973-GA; Fri, 16 Dec 2022 11:23:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A374300652;
        Fri, 16 Dec 2022 12:23:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5E6F209E6740; Fri, 16 Dec 2022 12:23:09 +0100 (CET)
Date:   Fri, 16 Dec 2022 12:23:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Marek <jonathan@marek.ca>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: camss: csiphy-3ph: avoid undefined behavior
Message-ID: <Y5xVHU5FBr5qzAOs@hirez.programming.kicks-ass.net>
References: <20221215162905.3960806-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215162905.3960806-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:28:46PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Marking a case of the switch statement as unreachable means the
> compiler treats it as undefined behavior, which is then caught by
> an objtool warning:
> 
> drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.o: warning: objtool: csiphy_lanes_enable() falls through to next function csiphy_lanes_disable()
> 
> Instead of simply continuing execution at a random place of the
> driver, print a warning and return from to the caller, which
> makes it possible to understand what happens and avoids the
> warning.
> 
> Fixes: 53655d2a0ff2 ("media: camss: csiphy-3ph: add support for SM8250 CSI DPHY")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index 451a4c9b3d30..04baa80494c6 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -429,7 +429,8 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
>  		array_size = ARRAY_SIZE(lane_regs_sm8250[0]);
>  		break;
>  	default:
> -		unreachable();
> +		WARN(1, "unknown cspi version\n");
> +		return;
>  	}

So no real objection here; but unreachable() does have an objtool
annotation inside, so clearly the compiler managed to defeat that --
perhaps we should look at that too.
