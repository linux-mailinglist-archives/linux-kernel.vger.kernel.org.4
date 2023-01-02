Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3A65B165
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjABLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjABLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:43:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519BE65BF;
        Mon,  2 Jan 2023 03:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEC760F63;
        Mon,  2 Jan 2023 11:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696BDC433F0;
        Mon,  2 Jan 2023 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672659758;
        bh=EZgYMe3usUyMFxbQO7E9BDjuwI3Npx6lVTgO4/S8MFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdC0XrF7edjW742EQEJus7c9GnSEDTpUnIvt+fqW8TVPeNCJ5Ru6eJbNOyG0n/yjz
         qZPEAjvcQYYx07slzR4FTxY4YQZMT2rubqAx8ZsVZPLDbIWi3nJ+UtevV09oSJ+9S3
         MsT9WvgfNmp8M0mwW3EirCrR1f/e2o6txxiLIQ9Q2Kdtu25FRbGL/KxWvtjtWczyOo
         Jz60kpGhFNyXQszqtsEf6t1c9K8lBRr55EUBrxMqSqYr/ACmehUlhgo+7FfSozZh3N
         IbA9qYCtsr+4YaE68Z+fiFNj+DlBKWzOVhqufr+27YeWmnRwZk/nSwNMhVvMfq7F80
         jzraRgyuzYwHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCJDS-0005PM-IM; Mon, 02 Jan 2023 12:42:55 +0100
Date:   Mon, 2 Jan 2023 12:42:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Message-ID: <Y7LDPgc+dnAMqwHU@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-7-johan+linaro@kernel.org>
 <6447bb2f-0ef1-a8a8-4b94-875e16954ca6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6447bb2f-0ef1-a8a8-4b94-875e16954ca6@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 12:16:44PM +0100, Konrad Dybcio wrote:
> 
> 
> On 2.01.2023 11:50, Johan Hovold wrote:
> > The wcd938x codec is not a memory-mapped device and does not belong
> > under the soc node.
> > 
> > Move the node to the root node to avoid DT validation failures.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> Third patch concerning the audio codec and third different
> order of properties :/ Please consolidate that.

It's arguably a separate change (even if I included it for the disabled
x13s node). I'm fixing the fact that the node should not have been added
under 'soc' in the first place.

Reordering properties can be done as a follow up if anyone cares enough,
even if I could possibly have renamed the node when moving it.

Johan
