Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14716F6538
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjEDGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEDGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:47:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187EC2122;
        Wed,  3 May 2023 23:47:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C134520525;
        Thu,  4 May 2023 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683182837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDagaQFzsZ+X9GWKn/xT7J4aIc1OKvEyKIFhHwtPMgk=;
        b=PVeZjaFbt6TEPGutiClK7mau8SsTl9qV+Zaf0LFyE7LCPv8DKTliYaRpLIPIWFJGiMaPjy
        y360f90sT+3lNAEyyTef67i9giIktruSWud2X5+PVZgUl3t1Yw3lRnbpccisDQR6p2/BCy
        3BGvidXrLOhG5NHzfJs88UU7oCDiVqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683182837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDagaQFzsZ+X9GWKn/xT7J4aIc1OKvEyKIFhHwtPMgk=;
        b=sumPTD+CaqYiz4s6NignUXOfxyjCdIK70MU9UHLPzPjdxfNcdXuo3w/XAJWcG9ljMWpXXb
        BgvKuSK4CwvIlxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B7EF139C3;
        Thu,  4 May 2023 06:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X26lIPVUU2THeQAAMHmgww
        (envelope-from <trenn@suse.de>); Thu, 04 May 2023 06:47:17 +0000
From:   Thomas Renninger <trenn@suse.de>
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Wyes Karny <wyes.karny@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        gautham.shenoy@amd.com, Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH] cpupower: Make TSC read per CPU for Mperf monitor
Date:   Thu, 04 May 2023 08:47:17 +0200
Message-ID: <4480921.LvFx2qVVIh@work.fritz.box>
In-Reply-To: <20230504062544.601566-1-wyes.karny@amd.com>
References: <20230504062544.601566-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 4. Mai 2023 08:25:44 CEST Wyes Karny wrote:
> This technique improves C0 percentage calculation in Mperf monitor.

I very much like this patch.
Would be nice to see it queued up if Shuah is ok with it.

Thanks for this one!

     Thomas


