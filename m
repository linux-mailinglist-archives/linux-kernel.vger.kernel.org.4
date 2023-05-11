Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5916FF239
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbjEKNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbjEKNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:10:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52205FEB;
        Thu, 11 May 2023 06:10:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5096C1FDF7;
        Thu, 11 May 2023 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683810648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kHWk0gaCy7sFq5ZjcvtYIgAcrVlu1oZLofczV71BSo=;
        b=GCERDsj+FKy6LW7J6+MdfkxxC8Acz6TXWjoh8a8oHTEWiH807oBwtkJzaaIqIGzyvLDzN+
        bbV4arMw5cn+/Z/Fy/ko5a3z/QBEwJx+w61/t8uJSQObCV9XplDbgQE65tSZrzs9Xx7IIm
        mfmAJ8cQSET96RDEtf6ud/bW4O0Vv4M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13816138FA;
        Thu, 11 May 2023 13:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id exAqA1jpXGTWHAAAMHmgww
        (envelope-from <mwilck@suse.com>); Thu, 11 May 2023 13:10:48 +0000
Message-ID: <095a2264120ad51d0500c4ce8221be2f88a9537e.camel@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
From:   Martin Wilck <mwilck@suse.com>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Date:   Thu, 11 May 2023 15:10:47 +0200
In-Reply-To: <20230511123432.5793-1-jgross@suse.com>
References: <20230511123432.5793-1-jgross@suse.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-11 at 14:34 +0200, Juergen Gross wrote:
> Some callers of scsi_execute_cmd() (like e.g. sd_spinup_disk()) are
> passing an uninitialized struct sshdr and don't look at the return
> value of scsi_execute_cmd() before looking at the contents of that
> struct.
>=20
> This can result in false positives when looking for specific error
> conditions.
>=20
> In order to fix that let scsi_execute_cmd() zero sshdr-
> >response_code,
> resulting in scsi_sense_valid() returning false.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 3949e2f04262 ("scsi: simplify scsi_execute_req_flags")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> I'm not aware of any real error having happened due to this problem,
> but I thought it should be fixed anyway.
> I _think_ 3949e2f04262 was introducing the problem, but I'm not 100%
> sure it is really the commit to be blamed.
> ---
> =A0drivers/scsi/scsi_lib.c | 14 ++++++++++----
> =A01 file changed, 10 insertions(+), 4 deletions(-)

One nitpick below, otherwise it looks good to me.

>=20
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index b7c569a42aa4..923336620bff 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -209,11 +209,17 @@ int scsi_execute_cmd(struct scsi_device *sdev,
> const unsigned char *cmd,
> =A0=A0=A0=A0=A0=A0=A0=A0struct scsi_cmnd *scmd;
> =A0=A0=A0=A0=A0=A0=A0=A0int ret;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0if (!args)
> +=A0=A0=A0=A0=A0=A0=A0if (!args) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0args =3D &default_args;
> -=A0=A0=A0=A0=A0=A0=A0else if (WARN_ON_ONCE(args->sense &&
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 args->sense_len !=3D
> SCSI_SENSE_BUFFERSIZE))
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> +=A0=A0=A0=A0=A0=A0=A0} else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Mark sense data to be in=
valid. */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (args->sshdr)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0arg=
s->sshdr->response_code =3D 0;

We know for certain that sizeof(*sshdr) is 8 bytes, and will most
probably remain so. Thus=A0

    memset(sshdr, 0, sizeof(*sshdr))

would result in more efficient code.

Martin

