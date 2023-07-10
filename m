Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2974D336
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjGJKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjGJKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:19:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB37183;
        Mon, 10 Jul 2023 03:19:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 547AF1FE4C;
        Mon, 10 Jul 2023 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688984373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOPQVlVl/8vQ//n15Tk8y4R1eYRMJsmZsPzlZqEUlNs=;
        b=Wp0QUbNf5XaNlRPlG0FB9Zz/3WpMnrs1+b8iNdyU95ruQBihKhwUs2PLtYeSAZOtTSK+PQ
        dF+kV5V87URc5OHxolj0z8nmgFGS2N/rPU+kqKb5kyMytUAObxYKCW3ywRqsRUMpqFqbjc
        E2Otgn39N453HG4U7uXxooZrh2mXB6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688984373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOPQVlVl/8vQ//n15Tk8y4R1eYRMJsmZsPzlZqEUlNs=;
        b=M1y7Pko3BRJD16IVNvY+R0b+D274u+SqFXOje3G1Pjo7N8uHPwvWSI9RgeXKoNNg74OR1j
        UIidc8Nvqy7uN/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4269513A05;
        Mon, 10 Jul 2023 10:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hac1EDXbq2SPPwAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 10 Jul 2023 10:19:33 +0000
Date:   Mon, 10 Jul 2023 12:19:32 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:53:17PM +0300, Max Gurtovoy wrote:
 > > Agree on setting the hard coded values for hostnqn and hostid instead of
> > > reading the /etc/nvme/* files. This should do the work IMO, isn't it ?
> > 
> > Do you mean that nvme-cli will ignore the udev trigger when a different hostnqn
> > is invovled? At least for the well-known discover controller the hostqnq
> > doesn't work. Though not sure if I understood you correctly here.
> 
> All I was saying is that your issue would have been fixed easily by 2-3 LOC
> by removing the usage of /etc/nvme/* files that are usually configured by
> system administrator and use a default values for blktests hostnqn and
> hostid.

Okay.

> The usage of --context in blktests is redundant IMO.

Right, I made a bit of a mess with the commit message. Sorry about that.
