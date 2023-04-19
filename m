Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B36E75F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjDSJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDSJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:03:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676EC19AA;
        Wed, 19 Apr 2023 02:03:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F69C218FA;
        Wed, 19 Apr 2023 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681895014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7j4qJXIawGY6mpyNjNiUk4lxy3e36PGk3TvZkti17I0=;
        b=Tj94UxfK6K7wLBKigrc77QBvPBsPY3QM40KxLpP4L0LQPc2W038uyhv3sIcCc9PE4Pl8BT
        He/xvrLP+yyOb7sNDD7lF7p08k55WDUc/AYRVXHGAXqN/4+sOFQxAfziCSTujQRivroeLw
        o43QR8IJGzXvf8OIqFION0pMXX+mx4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681895014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7j4qJXIawGY6mpyNjNiUk4lxy3e36PGk3TvZkti17I0=;
        b=53tm+o8syWXozVEDsTToCP6FxOj/tYgzwaWPw46EzsVUdElogZnK1JYTQ6i1RZDTcbFW5q
        J0w4T4jrXjagHGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 119F513580;
        Wed, 19 Apr 2023 09:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XglHBGauP2Q1fgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 09:03:34 +0000
Date:   Wed, 19 Apr 2023 11:03:33 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Message-ID: <srd2pdxk5vqchlrdimlbqxqdc6v6x2n4x7y4muyaajiy6fim6z@bnejs2qf5zhe>
References: <20230418130159.11075-1-dwagner@suse.de>
 <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
 <lum3oejitdb36ox2ec736kc73hzlmmnyr7jtg23wfa4t5slkvs@hm4u6xfnatcp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lum3oejitdb36ox2ec736kc73hzlmmnyr7jtg23wfa4t5slkvs@hm4u6xfnatcp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 04:26:27PM +0200, Daniel Wagner wrote:
> On Tue, Apr 18, 2023 at 03:43:22PM +0200, Daniel Wagner wrote:
> > On Tue, Apr 18, 2023 at 03:01:55PM +0200, Daniel Wagner wrote:
> > > nvme/041 (Create authenticated connections)                  [failed]
> > > nvme/042 (Test dhchap key types for authenticated connections) [failed]
> > > nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
> > > nvme/044 (Test bi-directional authentication)                [failed]
> > > nvme/045 (Test re-authentication)                            [passed]
> > 
> > I suppose these should be disabled for fc as all this is tcp specific.
> 
> After a fresh reboot the deleter tport, lport and rport trouble is back...
> 
> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>     runtime  10.265s  ...  10.365s
> tests/nvme/rc: line 198: /sys/class/fcloop/ctl/del_target_port: No such file or directory
> tests/nvme/rc: line 190: /sys/class/fcloop/ctl/del_local_port: No such file or directory
> tests/nvme/rc: line 182: /sys/class/fcloop/ctl/del_remote_port: No such file or directory

Eventually, I figured the out the root problem. The modules got unloaded before
the resource were freed. This explains a lot of the nasty problems I saw.
Anyway, I posted an updated blktests fixes but I think we should still consider
these patches here.

  https://lore.kernel.org/linux-nvme/20230419084757.24846-1-dwagner@suse.de/

BTW, the authentication tests fail for fc, but not for the rest. And after
reading up on it, it supposed to work on fc as well. So here we go first real
bugs found.
