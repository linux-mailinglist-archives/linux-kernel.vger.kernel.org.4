Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A27747431
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGDOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGDOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:35:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D69DE47;
        Tue,  4 Jul 2023 07:35:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E50C522432;
        Tue,  4 Jul 2023 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688481346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Jacfn/7Hr8ZOCMTak1z7qptVuLSxy2D+yd/NGiugyc=;
        b=dP4kzefg/ivdfntqveAu8p6SD7A7DK+2LqnFdcDWXKixHadmsQUUW/MDy2E3ysVzMuf7Hm
        oIWK1L4NbqXiPiQOp+uRx62ulzg4dvpzS182qClGjW2dsX53xcVickxbgIIqHL3N1GmIIA
        0ePI+GR0dwxP/N1j2jYk2+Vc43D3pJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688481346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Jacfn/7Hr8ZOCMTak1z7qptVuLSxy2D+yd/NGiugyc=;
        b=1t3YyoDdcql+sm1bmn3mFloQuC/6pAqKxQKD0y6vlQCGyUwIWq4e+TxkbKxJfsraHaDM8m
        7fiNVNurCajAHfCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B012E1346D;
        Tue,  4 Jul 2023 14:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JN6lKEIupGQOfwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 04 Jul 2023 14:35:46 +0000
Date:   Tue, 4 Jul 2023 16:35:44 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <20230704163544.660621f3@endymion.delvare>
In-Reply-To: <ZKQZHZt8YV0GosrZ@dhcp22.suse.cz>
References: <20230626123252.73dbc139@endymion.delvare>
        <ZJwLy5anSgFzbTUP@dhcp22.suse.cz>
        <20230704144312.032b4ddd@endymion.delvare>
        <ZKQZHZt8YV0GosrZ@dhcp22.suse.cz>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 15:05:33 +0200, Michal Hocko wrote:
> On Tue 04-07-23 14:43:12, Jean Delvare wrote:
> > On Wed, 28 Jun 2023 12:30:35 +0200, Michal Hocko wrote:  
> > > Would it make sense to also print the refcnt here? In our internal bug
> > > report it has turned out that this was an overflow (put missing) rather
> > > than an underflow (too many put calls). Seeing the value could give a
> > > clue about that. We had to configure panic_on_warn to capture a dump to
> > > learn more which is rather impractical.  
> > 
> > Well, other calls to module_put() or try_module_get() could happen in
> > parallel, so at the time we print refcnt, its value could be different
> > from the one which triggered the WARN.  
> 
> Racess with module_put should be impossible because all of them should
> fail, right?

Most probably yes, but after taking a deeper look at the code, I
wouldn't swear. For example delete_module() will decrement refcnt and
increment it again if the module can't actually be removed. This could
get refcnt to positive again briefly, at which point another
module_put() could succeed.

> Races with put are possible but we do not need an exact
> value to tell the difference between over and underflow, no?

Indeed not. But my other points still stand. Plus, if you really want
to know the refcnt value, it's already visible in /sys/module/*/refcnt
and lsmod.

-- 
Jean Delvare
SUSE L3 Support
