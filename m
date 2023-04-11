Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20E96DDEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDKPAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDKPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:00:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3D272B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:00:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82049219EF;
        Tue, 11 Apr 2023 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681225238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=obptCKCQzxtBRtmeQkubwSx5aUwtUWvLtRvvPs19XGQ=;
        b=xiYgXQh6gxorTUcefpy17ytbQFVYoPYIIOyBDppJuO9Yf602EaDVgh0z759AuDTGGNqkxX
        GqLaW/g2Q3cBmHeV0arsnzOFExcF8ERnQNJz8eMp94W5ilJbuk7tcgD2PeQiGkOYEw8/jr
        0zGRhaUvbmpX8CGzIx1PfFgphTq8nFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681225238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=obptCKCQzxtBRtmeQkubwSx5aUwtUWvLtRvvPs19XGQ=;
        b=u07dUPE9HzhxeWCrY8FmNs4IG1IMB95tbUdQVdqGEAqzigjbF68axqKAjGwJNPEEIRHtLU
        brVgJLTsWJFysYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7473D13638;
        Tue, 11 Apr 2023 15:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IedkHBZ2NWRobQAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 15:00:38 +0000
Date:   Tue, 11 Apr 2023 17:00:37 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH v2 0/4] nvmet-fcloop: unblock module removal
Message-ID: <sgoyzwj6ckrdrpq22u6fhtcemul5rqj6de4l5gw73vz77o3ils@vmv3jue4rom7>
References: <20230411120718.14477-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411120718.14477-1-dwagner@suse.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:07:14PM +0200, Daniel Wagner wrote:
>  loop: module loaded
>  run blktests nvme/003 at 2023-04-11 13:55:57
>  nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>  nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
>  (NULL device *): {0:0} Association created
>  [71] nvmet: ctrl 1 start keep-alive timer for 120 secs
>  nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
>  nvme nvme0: NVME-FC{0}: controller connect complete
>  nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>  nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
>  (NULL device *): {0:1} Association created
>  [453] nvmet: ctrl 2 start keep-alive timer for 5 secs
>  nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
>  [71] nvmet: adding queue 1 to ctrl 2.
>  [45] nvmet: adding queue 2 to ctrl 2.
>  [453] nvmet: adding queue 3 to ctrl 2.
>  [105] nvmet: adding queue 4 to ctrl 2.
>  nvme nvme1: NVME-FC{1}: controller connect complete
>  nvme nvme1: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
>  [453] nvmet: ctrl 2 reschedule traffic based keep-alive timer
>  [105] nvmet: ctrl 2 update keep-alive timer for 5 secs
>  [105] nvmet: ctrl 2 update keep-alive timer for 5 secs
>  nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>  [45] nvmet: ctrl 1 stop keep-alive
>  (NULL device *): {0:0} Association deleted
>  (NULL device *): {0:0} Association freed
>  (NULL device *): Disconnect LS failed: No Association

It turns out this sequence is triggered the udev auto connect rules. As I read
the _setup_nvmet() code, the connect should happen via blktest and not udev.
Obviously, this messes with the test case. I'll try to figure out how we can
disable the udev rules during test run.
