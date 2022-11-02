Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374A615CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKBHRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKBHRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E5B4A4;
        Wed,  2 Nov 2022 00:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAB661808;
        Wed,  2 Nov 2022 07:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9775BC433D6;
        Wed,  2 Nov 2022 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667373436;
        bh=7B515svrha9lAVshcKZWJ9DaQON4RrUzPOsPKoKlGqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhDzsJdmwGWhVhdbFIaYqNzrjbxI3oLJjWbBtObV4JL1TR5nodCf/lu8kaRkgW1kB
         +xTe+QRCh7qcckygkVHgAnaoh2Wck+1V6k6GV2/DWqL7t+7SPvdWnaLeDWVUB74vTD
         Hj3knkUxA1UzMneMbVfxDJjD2sTgsS5Dr92xfj68Uk6OyIaDkijr/PHb3v5EsCUxP/
         vI2aGq6flB0Y+6qLeBYAxFXN8U0LSXgotGoBjjzJeMzoB5g5ur6QnEpLu9Q0cnikXO
         LA0z64HlNaEJAsHB6kuQQ6LeOm98ffGXEd+c8+ICWMQhfnEOvtDwtGYwL2D+cnidIa
         N7rXXVDlbAA4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oq7zf-0001sl-P9; Wed, 02 Nov 2022 08:17:00 +0100
Date:   Wed, 2 Nov 2022 08:16:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        bmasney@redhat.com, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Message-ID: <Y2IZaxukERXNcPGR@hovoldconsulting.com>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
 <20221101182402.32CE5C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101182402.32CE5C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:23:59AM -0700, Stephen Boyd wrote:
> Quoting Shazad Hussain (2022-10-30 07:23:33)
> > Since 'commit f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref
> 
> So we should have a Fixes tag for this commit? Or really back to the
> beginning of the driver?
> 
> > clock for ufs_mem_phy")' we need to explicitly make cxo as parent to
> > gcc_ufs_ref_clkref_clk to have an independent vote from ufs_mem_phy.

The commit message is slightly misleading as this affects the other UFS
PHY as well.

If CX is indeed a parent of this clock then the issue has been there
since the clock driver was added. (And otherwise, the PHY binding may
need to be amended instead.)

Johan
