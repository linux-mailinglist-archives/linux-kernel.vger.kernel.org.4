Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494F73ED16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjFZVtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFZVth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2D9D;
        Mon, 26 Jun 2023 14:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C56A60F53;
        Mon, 26 Jun 2023 21:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBCEC433C0;
        Mon, 26 Jun 2023 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816175;
        bh=hpK0rbszcXwM0aqV/fAM9k6zUA3q2b9WFoG4zbe4uxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=teoL3iTd7VHqVFZfb24/wcozBy6+g5hCJPhjYgyupsc1xG4Lcsunzor0vvIFrfXxl
         p1fofHgS1QFRtRBkXLaYgg2RLTW2dUwZ413vBWESEMOsRt1IvTKcB6/N/1E6MJgaW5
         lWDiCVnbHvEXoejNgu/2TFMIid+GbEDISz5tmaMv8vFtAzfKZ4KBKbDKnHPuIdZ2J5
         C8lqp5QqXzUxeM9ubpK8uul87Tafz9ttUTXV/WrdImwjiNIsKgeV5wMP77ImqTR+MR
         MG3kxnGDLpfWJ5tEoeBGzmthZyVK2YAl0U3V13KDmW2sbWAsIXohD2qj+6qdomU9yT
         QquvwCBqaF6Bw==
Date:   Mon, 26 Jun 2023 14:49:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        dhowells@redhat.com, acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        davem@davemloft.net, irogers@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, netdev@vger.kernel.org, peterz@infradead.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
Message-ID: <20230626144934.4904c2ad@kernel.org>
In-Reply-To: <CAM9d7che_3z=NgT9OkrNmAQigY3Bo8nv16TVH6fgx8pn76xUbg@mail.gmail.com>
References: <2947430.1687765706@warthog.procyon.org.uk>
        <20230626090239.899672-1-matthieu.baerts@tessares.net>
        <20230626142734.0fa4fa68@kernel.org>
        <CAM9d7che_3z=NgT9OkrNmAQigY3Bo8nv16TVH6fgx8pn76xUbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 14:41:56 -0700 Namhyung Kim wrote:
> > Hi Arnaldo, are you okay with us taking this into the networking tree?
> > Or do you prefer to sync the header after everything lands in Linus's
> > tree?  
> 
> Arnaldo is on vacation now, and I'm taking care of the patches
> on behalf of him.
> 
> As it's introduced in the networking tree, it should be fine to
> carry the fix together.  I'll sync the header later.

Will do, thanks!

> But in general you don't need to change the copy of the tools
> headers together.  It also needs to support old & new kernels
> so different care should be taken.  Please separate tooling
> changes and let us handle them.

Ack, I'm not sure what makes this a special case, from Stephen's
original report:

https://lore.kernel.org/all/20230626112847.2ef3d422@canb.auug.org.au/

it sounded like perf won't build without the fix.
