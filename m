Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EA76A6976
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCAJHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCAJHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:07:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E42D159;
        Wed,  1 Mar 2023 01:07:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED1261FE15;
        Wed,  1 Mar 2023 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677661630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkvS1ZS82FkR5HQxCLJx+REXczDxk4WNj+Mp+puCHM4=;
        b=H/MKVg1p/0vH9xzgknFkRQ7tuzoTJF9Yz9FZFzVnsUYtD+3yI+hqJI1opwxd7vEidgCcNM
        4hJF2+Sso5DzmThl2jLCI0Cuzi4qpRYMIuOi2zlJqQbrmSUIAaJmHY46VMJdz3vrXPK5uL
        JXT6thmlrSk/I5xeuswqBHw5l1jloKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677661630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkvS1ZS82FkR5HQxCLJx+REXczDxk4WNj+Mp+puCHM4=;
        b=Ta1IMPKWQYpKkundfUx3BYXcDK3NjogyFD1iCkCzIs8I3IA3hlI+YRqskjXbkmKlafEJBJ
        c6vWAvHx8tHslvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFEB713A3E;
        Wed,  1 Mar 2023 09:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 24SjNr4V/2PzewAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 09:07:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6CCE3A06F2; Wed,  1 Mar 2023 10:07:10 +0100 (CET)
Date:   Wed, 1 Mar 2023 10:07:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: commit super block if fs record error when
 journal record without error
Message-ID: <20230301090710.hwjvumiikbe2vbdc@quack3>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-2-yebin@huaweicloud.com>
 <20230216173159.zkj4qd2nmj2yjpkr@quack3>
 <63EEDC19.6010204@huawei.com>
 <20230217105647.g6blbinkvnsyy2or@quack3>
 <63F03582.1020303@huawei.com>
 <20230227112001.hfcp7mmay6vzihck@quack3>
 <63FD65DA.6050805@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63FD65DA.6050805@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-02-23 10:24:26, yebin (H) wrote:
> On 2023/2/27 19:20, Jan Kara wrote:
> > On Sat 18-02-23 10:18:42, yebin (H) wrote:
> > > On 2023/2/17 18:56, Jan Kara wrote:
> > > > On Fri 17-02-23 09:44:57, yebin (H) wrote:
> > > > > On 2023/2/17 1:31, Jan Kara wrote:
> > > > > > On Tue 14-02-23 10:29:04, Ye Bin wrote:
> > > > > > > From: Ye Bin <yebin10@huawei.com>
> > > > > > > 
> > > > > > > Now, 'es->s_state' maybe covered by recover journal. And journal errno
> > > > > > > maybe not recorded in journal sb as IO error. ext4_update_super() only
> > > > > > > update error information when 'sbi->s_add_error_count' large than zero.
> > > > > > > Then 'EXT4_ERROR_FS' flag maybe lost.
> > > > > > > To solve above issue commit error information after recover journal.
> > > > > > > 
> > > > > > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > > > > > ---
> > > > > > >     fs/ext4/super.c | 12 ++++++++++++
> > > > > > >     1 file changed, 12 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > > > > index dc3907dff13a..b94754ba8556 100644
> > > > > > > --- a/fs/ext4/super.c
> > > > > > > +++ b/fs/ext4/super.c
> > > > > > > @@ -5932,6 +5932,18 @@ static int ext4_load_journal(struct super_block *sb,
> > > > > > >     		goto err_out;
> > > > > > >     	}
> > > > > > > +	if (unlikely(es->s_error_count && !jbd2_journal_errno(journal) &&
> > > > > > > +		     !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS))) {
> > > > > > > +		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> > > > > > > +		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> > > > > > > +		err = ext4_commit_super(sb);
> > > > > > > +		if (err) {
> > > > > > > +			ext4_msg(sb, KERN_ERR,
> > > > > > > +				 "Failed to commit error information, please repair fs force!");
> > > > > > > +			goto err_out;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > Hum, I'm not sure I follow here. If journal replay has overwritten the
> > > > > > superblock (and thus the stored error info), then I'd expect
> > > > > > es->s_error_count got overwritten (possibly to 0) as well. And this is
> > > > > > actually relatively realistic scenario with errors=remount-ro behavior when
> > > > > > the first fs error happens.
> > > > > > 
> > > > > > What I intended in my original suggestion was to save es->s_error_count,
> > > > > > es->s_state & EXT4_ERROR_FS, es->s_first_error_*, es->s_last_error_* before
> > > > > > doing journal replay in ext4_load_journal() and then after journal replay
> > > > > > merge this info back to the superblock
> > > > > Actually，commit 1c13d5c08728 ("ext4: Save error information to the
> > > > > superblock for analysis")
> > > > > already merged error info back to the superblock after journal replay except
> > > > > 'es->s_state'.
> > > > > The problem I have now is that the error flag in the journal superblock was
> > > > > not recorded,
> > > > > but the error message was recorded in the superblock. So it leads to
> > > > > ext4_clear_journal_err()
> > > > > does not detect errors and marks the file system as an error. Because
> > > > > ext4_update_super() is
> > > > > only set error flag  when 'sbi->s_add_error_count  > 0'. Although
> > > > > 'sbi->s_mount_state' is
> > > > > written to the super block when umount, but it is also conditional.
> > > > > So I handle the scenario "es->s_error_count && !jbd2_journal_errno(journal)
> > > > > &&
> > > > > !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS)". Maybe we can just store
> > > > > 'EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS' back to the superblock. But i
> > > > > prefer to mark fs as error if it contain detail error info without
> > > > > EXT4_ERROR_FS.
> > > > Aha, thanks for explanation! So now I finally understand what the problem
> > > > exactly is. I'm not sure relying on es->s_error_count is too good. Probably
> > > > it works but I'd be calmer if when saving error info we also did:
> > > > 
> > > > 	bool error_fs = es->s_state & cpu_to_le16(EXT4_ERROR_FS);
> > > > 
> > > > 	copy other info
> > > > 	err = jbd2_journal_load(journal);
> > > > 	restore other info
> > > > 	if (error_fs)
> > > > 		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> > > > 	/* Write out restored error information to the superblock */
> > > > 	err2 = ext4_commit_super(sb);
> > > > 
> > > > and be done with this. I don't think trying to optimize away the committing
> > > > of the superblock when we had to replay the journal is really worth it.
> > > > 
> > > > Does this solve your concerns?
> > > Thanks for your suggestion.
> > > 
> > > I think if journal super block has 'j_errno' ext4_clear_journal_err()
> > > will commit error info.  The scenario we need to deal with is:(1) journal
> > > super block has no 'j_errno'; (2) super block has detail error info, but
> > > 'es->s_state' has no 'EXT4_ERROR_FS', It means super block in journal has
> > > no error flag and the newest super block has error flag.
> > But my code above should be handling this situation you describe - the
> > check:
> > 
> > error_fs = es->s_state & cpu_to_le16(EXT4_ERROR_FS);
>
> Here, we do not need to backup 'error_fs', as
> 'EXT4_SB(sb)->s_mount_state' already record this flag when fs has error
> flag before do journal replay.

Yeah, right. We don't need error_fs variable and can just look at
EXT4_SB(sb)->s_mount_state.

> > will check the newest state in the superblock before journal replay. Then
> > we replay the journal - es->s_state may loose the EXT4_ERROR_FS flag if the
> > superblock version in the journal didn't have it. So we do:
> > 
> > if (error_fs)
> > 	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> > 
> > which makes sure EXT4_ERROR_FS is set either if it was set in the journal
> > or in the newest superblock version before journal replay.
>
> My modification is to deal with the situation we missed, and I don't want
> to introduce an invalid super block submission.  If you think my judgment
> is too obscure, I can send another version according to your suggestion.

So is the extra superblock write your only concern? Honestly, I prefer code
simplicity over saved one superblock write in case we had to replay the
journal (which should be rare anyway). If you look at the code, we can
writeout superblock several times in that mount path anyway.

> > > so we need to
> > > store error flag to 'es->s_state', and commit it to disk.If 'es->s_state'
> > > has 'EXT4_ERROR_FS', it means super block in journal has error flag, so
> > > we do not need to store error flag in super block.
> > Why do you think that if es->s_state has EXT4_ERROR_FS, the super block in
> > the journal has that flag? During mount, we load the superblock directly
> > from the first block in the filesystem and until we call
> > jbd2_journal_load(), es->s_state contains this newest value of the
> > superblock state. What am I missing?
> After jbd2_journal_load() 'es->s_state' is already covered by the super
> block in journal.  If there is super block in journal and 'es->s_state'
> has error flag this means super block in journal has error flag. If there
> is no super block in journal and 'es->s_state' has error flag, this means
> super block already has error flag.In both cases we can do nothing.

If what you wanted to say: "It is not necessary to write the superblock if
EXT4_ERROR_FS is already set." I tend to agree although not 100% because
journal replay could result in rewinding 's_last_error_*' fields and so
writing superblock would still make sense even if EXT4_ERROR_FS is set in
es->s_state after journal reply. That's why I wouldn't complicate things
and just always write the superblock after journal replay.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
