Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4EA5E9EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiIZKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiIZKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF44663D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2C2560B7B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF84DC433C1;
        Mon, 26 Sep 2022 10:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664186940;
        bh=gVXyyA5IAbFfV7vJ/QOv0MxnXnumH7DZXircDqF5Z70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmQHGprzaXKvnrjt+vF3CfG0A6mz05d101IvDpP0S0KlWA/HxV02WBqm7aJ/85fKO
         776eQFUJPgC7L8koUGoInyWAn2pq3tjO2Wuq1tJaAE3lYQNW1w0fnHhtUvXbulDefb
         HXgalDIaN+/D6rCOCQ2fpGYC9oBSD55ApXAp20ZQhWiCbmquWs8KVP+pwjZ874O/Ku
         eUR+d8MNkrIlEGjwBKad02tb2rHugUHFzpxGvXz6sxZBRE/XGdFqlGxB22WM2YuCMy
         SBtGpekUg9s3HWGnMKKU0pfGald1AlS+OoImzYUVydBIrgF2Vviyt86f8+cK+lbcJ8
         KLcwsluiqzqCQ==
Received: by pali.im (Postfix)
        id 00CE28A3; Mon, 26 Sep 2022 12:08:56 +0200 (CEST)
Date:   Mon, 26 Sep 2022 12:08:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] powerpc/85xx: p2020: Define just one machine
 description
Message-ID: <20220926100856.klwmxgujr7nv4qik@pali>
References: <20220819191557.28116-1-pali@kernel.org>
 <20220819191557.28116-6-pali@kernel.org>
 <638a2f98-5c23-85ba-c835-bce276312182@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <638a2f98-5c23-85ba-c835-bce276312182@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2022 10:02:47 Christophe Leroy wrote:
> > +static int __init p2020_probe(void)
> >   {
> > -	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
> > -		return 1;
> > -	return 0;
> > +	struct device_node *p2020_cpu;
> > +
> > +	/*
> > +	 * There is no common compatible string for all P2020 boards.
> > +	 * The only common thing is "PowerPC,P2020@0" cpu node.
> > +	 * So check for P2020 board via this cpu node.
> > +	 */
> > +	p2020_cpu = of_find_node_by_path("/cpus/PowerPC,P2020@0");
> > +	if (!p2020_cpu)
> > +		return 0;
> 
> This looks odd. I though all probe were using the compatible, and in 
> fact I have a series in preparation that drops all 
> of_machine_is_compatible() checks in probe functions and do it in the 
> caller instead, after adding a .compatible string in the machine 
> description.
> 
> Is there really no compatible that can be used for all p2020 ?

Really. There is none. I have looked into all available P2020 DTB files
(either externals passed by bootloader or kernel in-tree) and there is
no common compatible string. The only "common" thing is cpu node, how I
implemented it int this patch series.

And same issue is with boards with P101x and P102x DTB files.
