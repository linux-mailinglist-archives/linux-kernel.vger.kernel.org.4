Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F70665D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjAKOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAKOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:08:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF1270;
        Wed, 11 Jan 2023 06:08:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5E9417B5C;
        Wed, 11 Jan 2023 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673446130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NL+HnkITOgHJ0AagPsed/d+7cGSBCRxbVWfXMOm+fYo=;
        b=tVlRC1Qg/hU8p77dRFo8KJRw3dOMRYE3XNLcaVkDwUkrwWEKqRBZSpRd5eleFS2BU3Cp/c
        RAumpKoMM0DzgIejNhVbw6rf/UZX2h5i9b7XDFimvXxYzjtK4TeGwFScakDMmd2rFfwLoG
        avJULLL25juA7cbZKOO11fMoRp0wPJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673446130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NL+HnkITOgHJ0AagPsed/d+7cGSBCRxbVWfXMOm+fYo=;
        b=sYumW9XkOeV39MmAc6c+Rm/ccS/3ilVLvqmKKkg/QJsvUuZ2bVCAnHXhzt61dnKcBRjBCd
        MTLQiqJjGXNxWnAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B83A41358A;
        Wed, 11 Jan 2023 14:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GEfSLPLCvmNxBQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 11 Jan 2023 14:08:50 +0000
Date:   Wed, 11 Jan 2023 15:08:50 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lpfc: Handle gracefully failed FLOGI attempts in
 devloss callback
Message-ID: <20230111140850.cww4xgq5vtvrt6kx@carbon.lan>
References: <20230111113841.108588-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111113841.108588-1-dwagner@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:38:41PM +0100, Daniel Wagner wrote:
> When FLOGI attempts fail, the vport can be released via
> lpfc_nlp_release() function. This function will set the pointer to NULL
> and the node state to NLP_STE_FREED_NODE. Though it wont stop the
> devloss timer in the upper SCSI layer.
> 
> Hence when the devloss timer eventually fires,
> lpfc_dev_loss_tmo_callbk() is called and it tries to operate on vport
> NULL pointer.
> 
> Just do nothing in this case. To be extra cautions also check for the
> state and issue a warning if we have an inconsistency.

Ignore this one. Just saw the proper fix:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=97f256913c5d
