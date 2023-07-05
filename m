Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57174748676
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjGEOgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjGEOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778641B6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688567711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPFecaivr54rVjCWMqN8jp7NqN4gyR5hEtTh6S4C2F0=;
        b=Eo1TQ0thZJVsjl5o+HDYCI8sSLJoltubT4Vn7CtGF9MhI35qD98NNptn3CqIdtCXBWWnzY
        /trxraMMKQn/3URd3XVcfL8faIxuonFacfChAoczhVjvWSMn9lQe03LblbKUIH+3l9zV8v
        QocU+DQjs5Ja3bnxR+zXlx5mFWgeyuc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-xY6neCy7OrON2l2F-wqwEQ-1; Wed, 05 Jul 2023 10:35:10 -0400
X-MC-Unique: xY6neCy7OrON2l2F-wqwEQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e10763f3so47930926d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688567709; x=1691159709;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPFecaivr54rVjCWMqN8jp7NqN4gyR5hEtTh6S4C2F0=;
        b=D63YucVHzy8xFmQiNQ12uiF6wdQTlmU9XW3i/IuLr8JrLFrlFagXwz4MwsjjThT2vp
         qyyuXMvdQ8UlmDEM3Y+8wZ9nFaCjoLrUsFXNgSGDL2F74piId+IxBLngUWaguaO+cwzf
         AHTW9arvs6gKQ+WMZGfCXrOQP+2ES1N/zO5DBYaDAYImUHMzgZ8KwTe8RedIBIxU1jaR
         BAuXln93Re/NMgyAlT7YBtwnht3wAOsVnyudvtVcOv/DfvR6yfwRx3MaSHqnC8XYQbow
         aDHJIi+cpwwuC9nWxynX9SZOyyKsmY3NNo0Yc3jjtz8JppMH2bzfvET40T5yHwbyjbj3
         ahoQ==
X-Gm-Message-State: ABy/qLZlhA98GGPznxPddFKaT4jLv9Ze+WmahKB1fj3jsDx5M4K4VUoW
        mCZQrvb/IOFUBvouth1NhS79z/pTiFC0mPZ+rbtPhX3Yov+7ZaANSgpZ7V0anQV2QCw1JhDAC6x
        lclA/l9gwpvcyKfa5/naBfCdtZ9UwpaDp
X-Received: by 2002:ad4:5765:0:b0:630:44b:180d with SMTP id r5-20020ad45765000000b00630044b180dmr18862429qvx.25.1688567709469;
        Wed, 05 Jul 2023 07:35:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFyXlkEh+mHD4R3+SJyx2btDLMuQniRGZbkM0WraI/J70rRiNQccu387F7tHzH+jcR7nwgGA==
X-Received: by 2002:ad4:5765:0:b0:630:44b:180d with SMTP id r5-20020ad45765000000b00630044b180dmr18862413qvx.25.1688567709187;
        Wed, 05 Jul 2023 07:35:09 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:7f10:16a0:5672:9abf? ([2600:6c64:4e7f:603b:7f10:16a0:5672:9abf])
        by smtp.gmail.com with ESMTPSA id mz14-20020a0562142d0e00b006300e1db3ecsm13454637qvb.141.2023.07.05.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:35:08 -0700 (PDT)
Message-ID: <6105b8bf9d35ca2906094a0f9a58b5351bc741da.camel@redhat.com>
Subject: Re: [PATCH] scsi: lpfc: Fix a possible data race in
 lpfc_unregister_fcf_rescan()
From:   Laurence Oberman <loberman@redhat.com>
To:     Tuo Li <islituo@gmail.com>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>
Date:   Wed, 05 Jul 2023 10:35:08 -0400
In-Reply-To: <20230630024748.1035993-1-islituo@gmail.com>
References: <20230630024748.1035993-1-islituo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-30 at 10:47 +0800, Tuo Li wrote:
> The variable phba->fcf.fcf_flag is often protected by the lock=20
> phba->hbalock() when is accessed. Here is an example in=20
> lpfc_unregister_fcf_rescan():
>=20
> =C2=A0 spin_lock_irq(&phba->hbalock);
> =C2=A0 phba->fcf.fcf_flag |=3D FCF_INIT_DISC;
> =C2=A0 spin_unlock_irq(&phba->hbalock);
>=20
> However, in the same function, phba->fcf.fcf_flag is assigned with 0=20
> without holding the lock, and thus can cause a data race:
>=20
> =C2=A0 phba->fcf.fcf_flag =3D 0;
>=20
> To fix this possible data race, a lock and unlock pair is added when=20
> accessing the variable phba->fcf.fcf_flag.
>=20
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> =C2=A0drivers/scsi/lpfc/lpfc_hbadisc.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c
> b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index 5ba3a9ad9501..9d2feb69cae7 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -6961,7 +6961,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba
> *phba)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Reset HBA FCF states a=
fter successful unregister FCF */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irq(&phba->hbalock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phba->fcf.fcf_flag =3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_irq(&phba->hbalock=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phba->fcf.current_rec.fla=
g =3D 0;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*

This makes sense and looks good to me
Reviewed-by: Laurence Oberman <loberman@redhat.com>

