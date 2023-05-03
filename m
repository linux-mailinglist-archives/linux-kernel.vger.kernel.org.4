Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D696F52D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjECIMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjECIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:12:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936294C21;
        Wed,  3 May 2023 01:12:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 449DC200BE;
        Wed,  3 May 2023 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683101546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKOYF8DaplIKH+Sile2V6/F1QE14apRzKlMxxSUuStg=;
        b=gaouWjGNWRqDvWg25oqoPMDNtskfrHp8iYpILM8xPKeegLZPHAu0Pg87HpJc4LDVQMJFgp
        f4M2erMXrDKP38DHqFptc9lHB55t2bp6XDn43TkCwKejaFqxzkCMPpxlqFUJEoDg3tbz5A
        t63F0xrnPFYP0VWucP64BEIfjEA4b5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683101546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKOYF8DaplIKH+Sile2V6/F1QE14apRzKlMxxSUuStg=;
        b=p0GnPf1FK0N/lBj6yU5ED0jN0UvZ+R2CgRD+llkGoncTHBHcxeL42DNULmE+JbiHm+GUif
        DSUIJhbLtti9xDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3605313584;
        Wed,  3 May 2023 08:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S40nDWoXUmQSZwAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:12:26 +0000
Date:   Wed, 3 May 2023 10:12:25 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 1/2] nvme-rc: Cleanup fc ports in reverse
 order
Message-ID: <cavn776zwjjiefckoeg4igobtzlmxrp6et253hmakruvcyqxec@jvxrkwlw4ewe>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-2-dwagner@suse.de>
 <a58b526d-2e29-6c4a-e277-b684f98636eb@grimberg.me>
 <2zcb7p4hgdeuj4wud3ztizodqt3lu44ktewusaxot5jn3ifrlx@x6hha62vjrqu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2zcb7p4hgdeuj4wud3ztizodqt3lu44ktewusaxot5jn3ifrlx@x6hha62vjrqu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 10:07:06AM +0000, Shinichiro Kawasaki wrote:
> On Apr 19, 2023 / 12:41, Sagi Grimberg wrote:
> > 
> > 
> > On 4/19/23 11:47, Daniel Wagner wrote:
> > > We need to free the resources in the opposite order as we allocate them.
> > > 
> > > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > > ---
> > >   tests/nvme/rc | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > > index b44239446dcf..ec0cc2d8d8cc 100644
> > > --- a/tests/nvme/rc
> > > +++ b/tests/nvme/rc
> > > @@ -204,10 +204,10 @@ _cleanup_fcloop() {
> > >   	local remote_wwnn="${3:-$def_remote_wwnn}"
> > >   	local remote_wwpn="${4:-$def_remote_wwpn}"
> > > -	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> > > -			       "${remote_wwnn}" "${remote_wwpn}"
> > >   	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
> > >   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
> > > +	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> > > +			       "${remote_wwnn}" "${remote_wwpn}"
> > >   }
> > >   _cleanup_nvmet() {
> > 
> > Does this fix a bug? if it does, than it should probably be documented
> > that there is a driver bug because userspace teardown ordering should
> > not trigger a driver bug.
> 
> I think this fixes a bug, and it can be a left work to add another new test
> case. Daniel, what do you think?

Initially I thought this fixes a bug when unloading the fc module. But this
change was just really fixing. So stringly speaking I don't think it really
workarounds a bug in the fc module unloading. I left the change in the series as
I though it makes sense to do the operation in reverse order.

So in short it's really just a cosmetic fix for blktests.
