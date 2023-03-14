Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788306B9401
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCNMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjCNMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:38:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9639FE48
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:38:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB6A121B79;
        Tue, 14 Mar 2023 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678797456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVBTw+DhM3f21FrFggkTiJhwDRbP8puisI0B3bctBi4=;
        b=NNI7qJVrY9AfgBN1+WTOtIMk0eu42c7RuBv/uDrj1TZCbVeVIMbkeiYpkBXrYQKGwhqwjn
        HPsLeqrbpHE1XmP1O5yeif3mRP2xgkLczgY17ZKgUMip6lvaZSsL1YEkud87dAQCfsPl8q
        m6XNvsS4WHu1D+3c79yGaxDzfhjmTRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678797456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVBTw+DhM3f21FrFggkTiJhwDRbP8puisI0B3bctBi4=;
        b=VubHSHo+vtgYjD9mhi4VgkAw9xoWgHyNcvqAKRLa04IoeATwpEgc3hu7eIkMFALKADMOFj
        O9+42FZxsLO3Z7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B49D713A26;
        Tue, 14 Mar 2023 12:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 41W4KpBqEGQlXAAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 14 Mar 2023 12:37:36 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     oswalpalash@gmail.com
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ntfs_trim_fs
Date:   Tue, 14 Mar 2023 13:38:54 +0100
Message-Id: <20230314123855.27154-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <CAGyP=7cgTARo7opXbtgNvPbAg0RFTdO2+NVHXgr5LkC0ZAPkSQ@mail.gmail.com>
References: <CAGyP=7cgTARo7opXbtgNvPbAg0RFTdO2+NVHXgr5LkC0ZAPkSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IIUC, this was long since fixed at the time of your v6.0.8 report.
The mainline fix is 557d19675a470bb0a98beccec38c5dc3735c20fa, which was
backported to stable (v6.0.16) via
7e686013b7071f4c16644cfad8808e76097724c4.

Please try to check more recent kernels prior to reporting.

Cheers, David

