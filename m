Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4C6104AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiJ0VpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiJ0VpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9243F76971;
        Thu, 27 Oct 2022 14:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3846762523;
        Thu, 27 Oct 2022 21:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC66C433C1;
        Thu, 27 Oct 2022 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907109;
        bh=mTMAirvTRFpPduH/fF/LE6Jf3DwPW1HTbiNGhhjjb7Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g8Wqbn1zWUFFiBcPBZ2RiF1buP52eUOOhLy/mRUOVZsjtilVSn8JjeVzNS49IqQiD
         LBStX2zQAzpe+NzAhHyRdhNm8Ij3a8nARkHZf7n33XlDacB1n3GwIkFDkE4TMzMd+l
         NgAtrcqMth741cUIwqL3o4npNAuSRW+PMDqL+YlHkq/v5GS+9A/EslD/ac5ybYh/0W
         9mQZFXp5yt3YghtPFRG0gKbVbK28ww3MzP+X5Mh3tpHORpV/ndtNKI0XvQ4W9DXrpZ
         CUBg/EC+0yhvIzAD9LXvVczuhg8HGS7MOcs8bbTAhIJrbWLW4QepGI2F3M/KqZKTDW
         SYtPSLpBQ+AiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221026135215.nqndtcb2unxqwwux@houat>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech> <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech> <20221026020800.38AC8C433C1@smtp.kernel.org> <20221026135215.nqndtcb2unxqwwux@houat>
Subject: Re: [PATCH 4/4] clk: Warn if we register a mux without determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org
To:     maxime@cerno.tech
Date:   Thu, 27 Oct 2022 14:45:07 -0700
User-Agent: alot/0.10
Message-Id: <20221027214509.8EC66C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting maxime@cerno.tech (2022-10-26 06:52:15)
> On Tue, Oct 25, 2022 at 07:07:58PM -0700, Stephen Boyd wrote:
> >=20
> > You can grep for it:
> >=20
> >  $ git grep -W 'struct clk_ops .*=3D'
>=20
> TIL about -W. It's awesome, thanks

:)

>=20
> > but I'm fairly certain a coccinelle script can detect most of these
> > because clk_ops are usually statically defined (although not always).
> >=20
> > Either way I already see that 'owl_comp_div_ops' will trigger this
> > warning. And 'at91sam9x5_smd_ops' looks even more likely. Given that I'm
> > not super keen on applying this patch.
>=20
> It's the reason why I didn't return an error at first, I wanted to
> report that it's invalid and let to drivers the chance to be fixed
> still.
>=20
> Should I take your above comment as you'd rather have the affected
> drivers fixed in this patch and we then return an error, or is it that
> you don't want that patch at all?

You can try fixing all the drivers that are failing to meet this
requirement (found with grep) and if they are fixed we can start
printing the warning. That seems to be the practical approach to getting
this patch accepted. The TODO irks me to be honest. I'd rather we fix
everything and make it an error and be done with it.
