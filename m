Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B465BFB3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjACMOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbjACMOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:14:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8CB101CA;
        Tue,  3 Jan 2023 04:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D26AB80EC1;
        Tue,  3 Jan 2023 12:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EB4C433EF;
        Tue,  3 Jan 2023 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672748036;
        bh=bzCWDaEPdr7JZjES33xBZJhsQwEVh7CU6xNE8sJYyY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLllcBfpPFlc0iu4AyrX4aMJ49Yp//4+xXkLkPi+223M3u/mFLWu0C/ElKDY/UNwz
         4GaRGZSLYYh1In49K1tHBH/nkIhKgn2VBSrr44GHL33S/0Aqgp+bxBDBVU624NrDeV
         CYlju1ImB83Rsl4yn+uzAIKwz2oTTaONcdTvofbBoes+BAo2uX14E8MSJW9E15XzUc
         Wi0O2L8NGgj7GMK2wRkUSg7ChIAHAq2R/e3EuqgdAGPD9rJMWJfW1332RbP1XrMJB1
         FHs3ePc2uBjA36Q4leeoOmgJZRkOWKZMs85zprWa2Qmf99LpE8SzbDqTEEVxmAP9tm
         GAA0+LXO/NfFA==
Date:   Tue, 3 Jan 2023 13:13:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Message-ID: <Y7QcAe+l2J3NtRB6@lothringen>
References: <20221220112520.3596920-1-qiang1.zhang@intel.com>
 <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221231182508.GB205110@lothringen>
 <20221231190107.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588001E32A306F2166D55622DAF69@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588001E32A306F2166D55622DAF69@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 09:41:57AM +0000, Zhang, Qiang1 wrote:
> > > >On Sat, Dec 31, 2022 at 07:25:08PM +0100, Frederic Weisbecker wrote:
> 
> Yes,    and I have a question,  we forcing the tick dependency because the expedited grace period
> is not end for the first time, this means that it is not to set the tick dependency every time.
> if we set the tick dependency in rcu_exp_handler(), does this mean that every time the expedited
> grace period starts the tick dependency will be set unconditionally ?
> 
> Thoughts ?

Only if rcu_exp_handler() fails to report a quiescent state. Then it means we
must poll on the CPU looking for a future one.

In fact the tick dependency should be set when rdp->cpu_no_qs.b.exp is set to
true and cleared when rdp->cpu_no_qs.b.exp is set to false.

Thanks.

> 
> Thanks
> Zqiang
> 
> >
> >							Thanx, Paul
