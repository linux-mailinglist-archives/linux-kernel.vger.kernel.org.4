Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB065D473
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbjADNh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjADNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:37:25 -0500
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 05:37:17 PST
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net (p3plsmtpa12-02.prod.phx3.secureserver.net [68.178.252.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FBB11
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:37:17 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id D3v2pfNMzdnFID3v3pOI73; Wed, 04 Jan 2023 06:35:01 -0700
X-CMAE-Analysis: v=2.4 cv=OtSJiQzt c=1 sm=1 tr=0 ts=63b58085
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=10cxsorouKqAV6tjQI0A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Wed, 4 Jan 2023 13:34:59 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v12 2/6] mm/vmstat: Use vmstat_dirty to track
 CPU-specific vmstat discrepancies
Message-ID: <20230104133459.5yaflf3yicpmhbbh@ava.usersys.com>
References: <20221227121137.102497574@redhat.com>
 <20221227121341.981235373@redhat.com>
 <20221230132132.GA186035@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221230132132.GA186035@lothringen>
X-CMAE-Envelope: MS4xfFA/uiN5hbKR/L31JmptVVhPRsARrLU7WBDehIBzhMxSZcxbBRUHhVl5Q3RD9uMKRFoYIB6a9w+0oldFH4hNfryhz98qvH5hD2s7YKCfhbG/wW1toJr8
 ibdeHnwgiZ5xuZQgFsoruKjde1wlQe7xGBXq6DG0OZd66zFZ0bR55hlRdhPobkaMNpc1zGsv2vJiI0hlQ6eL23baSaapoe+p/KwdsViua2WPV5o1CHBYSWpW
 EgXeY0oNbfEbjHzGmoTMH8dR0XegGWkrvGOLSR6gnB9DZLgudtEngQcLdeEaca8SXBPGKLNH1pBYj3BBAWREpABvBQHIv8VbCqnpOfKyfNRETKexXOXQfQ4J
 5r/y+9bMe4iywjpm7R3vQ2Mg91dtGTlhnQUx6nIECbDikyein5POLuPVRmU47edKImUfpBlJOs9BjxUoJdplajJRHHZjuJ8T0W5yRsf4gXSnYwMFbYqLGgqQ
 XsuPxuDLkxEUoVvN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-12-30 14:21 +0100, Frederic Weisbecker wrote:
> On Tue, Dec 27, 2022 at 09:11:39AM -0300, Marcelo Tosatti wrote:
> > @@ -606,6 +608,7 @@ static inline void mod_zone_state(struct
> >  
> >  	if (z)
> >  		zone_page_state_add(z, zone, item);
> > +	vmstat_mark_dirty();
> >  }
> >  
> >  void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> > @@ -674,6 +677,7 @@ static inline void mod_node_state(struct
> >  
> >  	if (z)
> >  		node_page_state_add(z, pgdat, item);
> > +	vmstat_mark_dirty();
> 
> Looking at this further, about the two above chunks, there is a risk to
> mark the wrong CPU dirty because those functions are preemptible and rely
> on this_cpu_cmpxchg() to deal with preemption.

Hi Frederic,

Agreed.


Kind regards,

-- 
Aaron Tomlin
