Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC9736D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjFTN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjFTN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:27:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A391185;
        Tue, 20 Jun 2023 06:27:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC88E21228;
        Tue, 20 Jun 2023 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687267636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wKacNcJVLmesRp8TReg+QyYHTEChm9F06o8ZZWC2XNU=;
        b=etp644gKfqe6QazNfpm5X5Ns1cefjHGkwJoHwV3juMcvziqq3FoPUXrBunj2J9rbFDsQjj
        2bG3Pwvu1YURas3RYqwKj5YvUrJ4TSEWxSzB/HgAZeERpUSFJo2QjOaJ7S3mSZpuH5COqU
        S8mh0cRjFzv2Y0u4FNLQul22WA85S3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687267636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wKacNcJVLmesRp8TReg+QyYHTEChm9F06o8ZZWC2XNU=;
        b=BMBGRqQFIOvcvE3Oey9DaN31ZhziAS9EXA9VOjgFljUINLT5vyTbNAhOYPA/6ZBxCWvLO0
        GXMDyHHavClkOwCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE1751346D;
        Tue, 20 Jun 2023 13:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FnxKMjSpkWSaOAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:27:16 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/3] More fixes for FC enabling
Date:   Tue, 20 Jun 2023 15:27:00 +0200
Message-ID: <20230620132703.20648-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is addressing the problem, that the FC transport is way faster
in reconnecting and the test didn't observe all the states from live ->
resetting -> connecting -> live. Instead trying to see these transitions just
test for the final state which is live and the correct number of queues. This
makes this test also a little bit more robust. So this patch is necessary.

The next two patches are more in RFC state but I think it makes sense to post
them along side the rest.

The second and the third patch rely on the not yet released nvme-cli features
'volatile configuration' and 'execution context awareness'. These two feature
allow nvme-cli to figure out if a 'nvme connect' should actually be done or just
ignored. If the FC autoconnect udev/systemd rules are enabled on a host, this is
interfering with blktests. Note, this is also a way to get nvme-stas and
nvme-cli play nicely with each other.

In case anyone wants to run blktest with FC as transport needs either to disable
the autoconnect feature or use the unreleased features of nvme-cli.

Daniel Wagner (3):
  nvme/048: Check for queue count check directly
  nvme/rc: Avoid triggering host nvme-cli autoconnect
  nvme/{041,042,043,044,045}: Use default hostnqn and hostid

 tests/nvme/041 |  8 ++----
 tests/nvme/042 |  8 ++----
 tests/nvme/043 |  8 ++----
 tests/nvme/044 |  8 ++----
 tests/nvme/045 |  8 ++----
 tests/nvme/048 | 35 ++++++++++++++++--------
 tests/nvme/rc  | 73 +++++++++++++++++++++++++++++++++++++++++++-------
 7 files changed, 97 insertions(+), 51 deletions(-)

-- 
2.41.0

