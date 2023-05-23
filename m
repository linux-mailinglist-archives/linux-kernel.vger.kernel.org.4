Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1983470DD36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbjEWNJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEWNIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:08:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F5F109;
        Tue, 23 May 2023 06:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A776860B29;
        Tue, 23 May 2023 13:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C32AC4339B;
        Tue, 23 May 2023 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684847328;
        bh=1cEZ+kYR9C4Ji08kylg8DBnD3wDn0362SQowHihMxSU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OvoEbW0nJk1ROtTu1SHysGXvFjcKP8MDT4+VAuTAAPRY0vX5mcG4vBBkoV6ug5fTH
         D4RgNiF6AuU/WW/qT6jkUxX/fbw0BX67K5pxxBsl9nDFo/K1loJRGSQCE45Rfkwl1P
         oiEU1FqQE5T65Il3OGslHnIaDhq2a9BU+YYfZc/18HsabXhHMaKzezz8o7bzpZVnsh
         I6zYwBmHc1fcWb12+QVO755UFWUZ/nt2JUrg8h4X3T4/M+tZakWWA4Mf6saGCu9FYS
         fOR4g2ibYWKzU6aDWugIbK2INM+9af3a8DKuW9DkktZcUoFORv8CxsQ4TzfPrZArmH
         IevNwkgdRKCtQ==
Date:   Tue, 23 May 2023 15:08:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] HID: wacom: avoid integer overflow in
 wacom_intuos_inout()
In-Reply-To: <20230417160148.60011-1-n.zhandarovich@fintech.ru>
Message-ID: <nycvar.YFH.7.76.2305231508330.29760@cbobk.fhfr.pm>
References: <20230417160148.60011-1-n.zhandarovich@fintech.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Nikita Zhandarovich wrote:

> If high bit is set to 1 in ((data[3] & 0x0f << 28), after all arithmetic
> operations and integer promotions are done, high bits in
> wacom->serial[idx] will be filled with 1s as well.
> Avoid this, albeit unlikely, issue by specifying left operand's __u64
> type for the right operand.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 3bea733ab212 ("USB: wacom tablet driver reorganization")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Applied. Thanks for the fix, and sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

