Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3531C603BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJSIh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJSIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:37:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8975FF70;
        Wed, 19 Oct 2022 01:37:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51CC72036B;
        Wed, 19 Oct 2022 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666168638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OnRTNV6BJLlEJNjkgcYAe4uit2FAkqV3YDM031DnAjE=;
        b=qdw21VjJrnUFHHve/t0gJpZJrl62EO2IZSnjlOAoITfWFEkT0wpCEuSbRCqVZ9vmZXb3y0
        x56RQLq+J70YeXXpA2v3tuQvylQx6txaPSegsN6SboM3fwSfttzOd3H3X09O/LZoBJ58oN
        fr2xkdlVhofeo9oW/ZbtnBd/fRUkTzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666168638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OnRTNV6BJLlEJNjkgcYAe4uit2FAkqV3YDM031DnAjE=;
        b=xKJYrZFcwpB00oIPj6Yk7HYJL59Obnxgk8Jw2A58hltPHw4q8T0IssWxG+RVIqTyR21Eho
        IFV7pgcjnpXexVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 408DD13345;
        Wed, 19 Oct 2022 08:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Api1Dz63T2M/ZQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 19 Oct 2022 08:37:18 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 0/5] padata: fix liftime issues after ->serial() has completed
Date:   Wed, 19 Oct 2022 10:37:03 +0200
Message-Id: <20221019083708.27138-1-nstange@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series is supposed to fix some lifetime issues all related to the fact that
once the last ->serial() has been invoked, the padata user (i.e. pcrypt) is well
with its right to tear down the associated padata_shell or parallel_data
instance respectively.

Only the first one, addressed by patch [2/5], has actually been observed, namely
on a (downstream) RT kernel under a very specific workload involving LTP's
pcrypt_aead01. On non-RT, I've been unable to reproduce.

The remainder of this series, 3-5/5, fixes two more, somewhat related, but
purely theoretical issues I spotted when scratching my head about possible
reasons for the original Oops.

Thanks!

Nicolai

Nicolai Stange (5):
  padata: introduce internal padata_get/put_pd() helpers
  padata: make padata_free_shell() to respect pd's ->refcnt
  padata: grab parallel_data refcnt for reorder
  padata: split out dequeue operation from padata_find_next()
  padata: avoid potential UAFs to the padata_shell from padata_reorder()

 kernel/padata.c | 129 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 33 deletions(-)

-- 
2.37.3

