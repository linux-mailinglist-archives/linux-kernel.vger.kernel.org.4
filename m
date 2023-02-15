Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D576977D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjBOIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjBOIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:14:47 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B48976B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HupHpkbzSPZDhis2vo8RKGLvZx4naguscrasKfve9PQ=;
        t=1676448885; x=1677658485; b=cekkaaeedJ5nSCkOZ6o4Xvr3typN4b4nGl3zJfWmDumFoyO
        fGE2bKLt9WmnnPSPj3ZKT1abpTwvj+CuE3LutUvaP1G1UMAqX9dhUMtLbTYqRKrRHDD9ursf8Bu5i
        obqmsRfD3bJZM6xiolfsLdaek0WmReMI4Jk102hGXFEadmrzTNic5hfehNFvyf64FKSpmQ9JrSL42
        0yFKPWJuZkzj+PPxviyQLLtufB6nFwm/INlqz96l6/SiKzaZ2/DPeLByPxIefR8Ff4YII39+ptz4i
        zLIHTxlhDpG3vmxPkE1SWqjdzQmEmthrfIa01IFxrK0qVFG4qajTIjMpcAN6DFhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSCw4-00CyrC-14;
        Wed, 15 Feb 2023 09:14:40 +0100
Message-ID: <d42dc4ea6f1d473ef4c721cbe67907538bb681a6.camel@sipsolutions.net>
Subject: Re: [PATCH V1] um: Fix compilation warnings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Richard Weinberger <richard@nod.at>,
        Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Feb 2023 09:14:39 +0100
In-Reply-To: <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
         <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-14 at 22:57 +0100, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Srinivasarao Pathipati" <quic_c_spathi@quicinc.com>
> > static void sig_handler_common(int sig, struct siginfo *si, mcontext_t =
*mc)
> > {
> > -	struct uml_pt_regs r;
> > +	struct uml_pt_regs *r;
> > 	int save_errno =3D errno;
> >=20
> > -	r.is_user =3D 0;
> > +	r =3D malloc(sizeof(struct uml_pt_regs));
>=20
> I fear this is not correct since malloc() is not async-signal safe.

It would probably also be a non-trivial performance regression for
'interrupt' handling.

We _could_ use a static if this really was a problem, but that'd be just
one more thing to undo for SMP, and see my other mail, it's really not
needed to worry about htis.

johannes
