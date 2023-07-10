Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4099374DC09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGJRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGJRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:13:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C21813D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:13:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A75A20098;
        Mon, 10 Jul 2023 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689009193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsMS0DlhrpMEuR7nFBsrcQoVkbT4l+w8hmmcBp3sw0E=;
        b=c+HByhagpM+GFey1o84QKdsmP3tOhZ40glAnELHvVVi6TQ0lJUjmZWZQ7YfxY9WlrCypH0
        I1RGk1QqAq9lMPiDY1t1YpS+Jyw4YRYP8xg1TLuGS+3lf7iqGFVs6o6TmamOjV+ZdNVQY6
        fHJsYBOfPWRSbw/yPUikvsckn34kMUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689009193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsMS0DlhrpMEuR7nFBsrcQoVkbT4l+w8hmmcBp3sw0E=;
        b=LGkmUkLG0a2AwS1rXcJSzrZFwQ0MHHH7rrpAWwcQ/1kWYAzVBHA/S7IbMd2XDjngA97wyA
        F1sJeXtm+MO4+ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FD2F13A05;
        Mon, 10 Jul 2023 17:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qm1KESg8rGSYEAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 10 Jul 2023 17:13:12 +0000
Date:   Mon, 10 Jul 2023 19:13:10 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, sam@ravnborg.org,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH v2] uapi/netfilter: Prefer ISO-friendly __typeof__
Message-ID: <20230710171310.GA671729@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230504083613.3789010-1-pvorel@suse.cz>
 <CAK7LNAS_0yOTtw36xfCtnBKFMkG_96nOSoyD4hejfacYUwW3Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAS_0yOTtw36xfCtnBKFMkG_96nOSoyD4hejfacYUwW3Eg@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 4, 2023 at 10:36 AM Petr Vorel <pvorel@suse.cz> wrote:

> > typeof() is a GNU extension, UAPI requires ISO C, therefore __typeof__()
> > should be used.  Similarly to 31088f6f7906 ("uapi/linux/const.h: Prefer
> > ISO-friendly __typeof__") use __typeof__() also in x_tables.h.

> > Fixes: 72b2b1dd77e8 ("netfilter: xtables: replace XT_ENTRY_ITERATE macro")
> > Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>


> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


Hi Andrew,

gently ping, could you please merge this to next tree?
Or do we need to wait to next merge window?

Kind regards,
Petr

> > ---
> > Changes v1->v2:
> > * Add Kevin's Reviewed-by:
> >   https://lore.kernel.org/lkml/f8bd4212-9cca-03ca-884a-c9dec63bb256@arm.com/
> > * Update hash to 31088f6f7906 (Kevin)
> > * Add Fixes: 72b2b1dd77e8 (Kevin)

> >  include/uapi/linux/netfilter/x_tables.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)

> > diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
> > index 796af83a963a..d4eced07f2a2 100644
> > --- a/include/uapi/linux/netfilter/x_tables.h
> > +++ b/include/uapi/linux/netfilter/x_tables.h
> > @@ -172,11 +172,11 @@ struct xt_counters_info {

> >  /* pos is normally a struct ipt_entry/ip6t_entry/etc. */
> >  #define xt_entry_foreach(pos, ehead, esize) \
> > -       for ((pos) = (typeof(pos))(ehead); \
> > -            (pos) < (typeof(pos))((char *)(ehead) + (esize)); \
> > -            (pos) = (typeof(pos))((char *)(pos) + (pos)->next_offset))
> > +       for ((pos) = (__typeof__(pos))(ehead); \
> > +            (pos) < (__typeof__(pos))((char *)(ehead) + (esize)); \
> > +            (pos) = (__typeof__(pos))((char *)(pos) + (pos)->next_offset))

> > -/* can only be xt_entry_match, so no use of typeof here */
> > +/* can only be xt_entry_match, so no use of __typeof__ here */
> >  #define xt_ematch_foreach(pos, entry) \
> >         for ((pos) = (struct xt_entry_match *)entry->elems; \
> >              (pos) < (struct xt_entry_match *)((char *)(entry) + \
> > --
> > 2.40.0
