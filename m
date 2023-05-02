Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A7A6F44E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjEBNTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:19:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEFA5B87;
        Tue,  2 May 2023 06:19:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CC2B1F8C4;
        Tue,  2 May 2023 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683033567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6pmLXaIP92O+42lHElbilcuYtyXI0aaCgcPWEIGhNs=;
        b=lChvKPHqaLxkunCNmmwMvq/Vkym78EMnsImduafFgSNkhQ8p+/x79wmSpYUdLrfeE/PSny
        7z3zm7/L+EbvQGLa4muacIEeNa9d/rK0S0zR5ZU0o/cTaekuqmExVr/h0AjaPEx2GSGKeV
        uTDbdm0dcS+YXwPz176/qE2vENUwTOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683033567;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6pmLXaIP92O+42lHElbilcuYtyXI0aaCgcPWEIGhNs=;
        b=/o1fQ6Bn2kXO2MZVvv6jlMBG087zAk+KyUBzIUmXFGEXu1Wx06aA85WFRDL9NPjxSZtcZM
        QGYDD0gxUYc8LfAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D320134FB;
        Tue,  2 May 2023 13:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6buhCt8NUWQEVwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 13:19:27 +0000
Date:   Tue, 2 May 2023 15:19:26 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <pjzkjnq7gv574bcnfmuf5n3ehgygqp2b2ybuburc7rty5iwhwf@dc6fkxg3wt5h>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:27:35AM +0200, Hannes Reinecke wrote:
> > +		avail="$(df --output=avail "${mount_dir}" | awk 'NR==2 {print $1}')"
> 
> df --output=avail "${mount_dir}" | tail -1

ok.

> > +		sz="$(printf "%d" $((avail / 1024 - 1 )))m"
> 
> sz=$((avail / 1024 - 1))
> 
> > +	fi
> > +
> >   	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
> 
> _run_fio_verify_io --size="${sz}m" --directory="${mount_dir}/"

$sz might already contain the 'm', so can't do this here.
