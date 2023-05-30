Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B2716F82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjE3VPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjE3VPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:15:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871A9138;
        Tue, 30 May 2023 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685481291; x=1717017291;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kP3IzRcNnl5fizRI+YuizgSNvrAVapWMHLTUNUcbfpE=;
  b=RZeyZ3QY41q45Cp8ZXpY4z/9ubGCzj6JiDZl8BeBezkZx0fuzgCDaijT
   u9v2QMrJ8Vo3NMMBYqmFS7DaIpMcLejJ1EWMFuNIZxIgBXUZv38tEue4Q
   GFztd7GBUje0z/tplGSnQzGR5/Fig/0ygbA4t+Y3eAxAZMFsVNom+bKwa
   RCGFVu5NOtQXXMLLDZmlkvYbNubmEBWZ9+edHccB/XyhAtdybq1uKNkZw
   9rxRrmf33esfjOA/Fyvrkt4FACWNMWgwSMmZzFQbe3riAUxS9GZ9tFMQj
   IApuxVpY6GEq2J0GoOqDph2b4kKibw+i9ngcovYyRUTiHde4w/D753XoA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="335398994"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="335398994"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="850946373"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="850946373"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.17])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:14:17 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Ferenc Fejes <ferenc.fejes@ericsson.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Roger Quadros <rogerq@kernel.org>,
        Pranavi Somisetty <pranavi.somisetty@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Subject: Re: [PATCH net-next 1/5] net/sched: taprio: don't overwrite "sch"
 variable in taprio_dump_class_stats()
In-Reply-To: <20230530091948.1408477-2-vladimir.oltean@nxp.com>
References: <20230530091948.1408477-1-vladimir.oltean@nxp.com>
 <20230530091948.1408477-2-vladimir.oltean@nxp.com>
Date:   Tue, 30 May 2023 14:14:17 -0700
Message-ID: <87edmxv7x2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> In taprio_dump_class_stats() we don't need a reference to the root Qdisc
> once we get the reference to the child corresponding to this traffic
> class, so it's okay to overwrite "sch". But in a future patch we will
> need the root Qdisc too, so create a dedicated "child" pointer variable
> to hold the child reference. This also makes the code adhere to a more
> conventional coding style.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

The patch looks good:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

But I have a suggestion, this "taprio_queue_get() ->
dev_queue->qdisc_sleeping()" dance should have the same result as
calling 'taprio_leaf()'.

I am thinking of using taprio_leaf() here and in taprio_dump_class().
Could be a separate commit.


>  net/sched/sch_taprio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 76db9a10ef50..d29e6785854d 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2388,10 +2388,10 @@ static int taprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
>  	__acquires(d->lock)
>  {
>  	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
> +	struct Qdisc *child = dev_queue->qdisc_sleeping;
>  
> -	sch = dev_queue->qdisc_sleeping;
> -	if (gnet_stats_copy_basic(d, NULL, &sch->bstats, true) < 0 ||
> -	    qdisc_qstats_copy(d, sch) < 0)
> +	if (gnet_stats_copy_basic(d, NULL, &child->bstats, true) < 0 ||
> +	    qdisc_qstats_copy(d, child) < 0)
>  		return -1;
>  	return 0;
>  }
> -- 
> 2.34.1
>

-- 
Vinicius
