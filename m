Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E556B868F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCNAGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCNAGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:06:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193518ABF5;
        Mon, 13 Mar 2023 17:06:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2F19229D2;
        Tue, 14 Mar 2023 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678752391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IPlAhnHZI1/4kHDq0dvU4vpeu5ilx6uAt/un6KbOR/s=;
        b=nRdCMirlRiU+GSor//GA1fKYBhQAGJJ05d6LvtCuznLaMnPHwNfzIp/cQVXaLTuqi04vjG
        AspOnM1iNVObgSwv6CJJCnZvSHsNSiBgYKFSMFXYvpNGBCiIndwzgcvvKkUkVk/Zuw7UjV
        x/0Ct9VhL7pYbnBtbu81zEDi2F5cjIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678752391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IPlAhnHZI1/4kHDq0dvU4vpeu5ilx6uAt/un6KbOR/s=;
        b=QB8GmDsmLLVzTdUVS6UkHXLoaDRFha5HvjKOIXSDq8tgrkBdygpmgcUgGZCTHtk3Sm+Frn
        /0pDHH9mJlG6xfCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6481613A1B;
        Tue, 14 Mar 2023 00:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wsN0B4W6D2SOagAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Mar 2023 00:06:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
To:     Jes Sorensen <jes@trained-monkey.org>
Subject: [PATCH - mdadm] mdopen: always try create_named_array()
Date:   Tue, 14 Mar 2023 11:06:25 +1100
Message-id: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


mdopen() will use create_named_array() to ask the kernel to create the
given md array, but only if it is given a number or name.
If it is NOT given a name and is required to choose one itself using
find_free_devnm() it does NOT use create_named_array().

On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result in
failure to assemble an array.  This can particularly seen when the
"name" of the array begins with a host name different to the name of the
host running the command.

So add the missing call to create_named_array().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217074
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mdopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mdopen.c b/mdopen.c
index d18c931996d2..810f79a3d19a 100644
--- a/mdopen.c
+++ b/mdopen.c
@@ -370,6 +370,7 @@ int create_mddev(char *dev, char *name, int autof, int tr=
ustworthy,
 		}
 		if (block_udev)
 			udev_block(devnm);
+		create_named_array(devnm);
 	}
=20
 	sprintf(devname, "/dev/%s", devnm);
--=20
2.39.2

