Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D785B6CBCED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjC1K46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1K44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985572AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680000975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tx6w/NoxDwZy1sJXzEpKewVTB38oj2z0f8QKEmor2kM=;
        b=D47Jro1zActPrE+a2ZjgXoP89jynZTmjaJRXkbSC8ALinUBqZMJPa1Ilc9KMwpTOwWsFde
        kpUbfcVvPw3jCMplZDx7u0f9GvSshMOYAsEvnCIVX+wdo0vSLg2Lqk7u3LnhPw28FrZhHI
        FZuGvhPCL5eeqHHesw8ko+zzv4RbWW0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-AO2iqbjbPoCEh2Lmnh31uQ-1; Tue, 28 Mar 2023 06:56:14 -0400
X-MC-Unique: AO2iqbjbPoCEh2Lmnh31uQ-1
Received: by mail-qk1-f198.google.com with SMTP id c186-20020a379ac3000000b007484744a472so5144943qke.22
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680000974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tx6w/NoxDwZy1sJXzEpKewVTB38oj2z0f8QKEmor2kM=;
        b=JuPJONg+7Yb0wvlplINQhs97US8KQdc1RSmlxRw7UI8/6f2Kpw5anzbf1r3f51V+M2
         /fGMmKPjFTS3LTmNyyrs+F+ZaYjnIpAoFjY9b8mJUGByUDznigIyY6dJAYiXdI0GXBfD
         rK/dCMewMlo9oOiqB/abRXzpixb0cHSf7chGKEZ0Qea8qYeTpfaDofL0J3sFpkW9tqce
         gxusJPrWVXA3dx8DKijBo/rzKY1myzNoHDc/87ydjt3OREkcKKHbYAOI9/YcF+XQ3+/h
         MG5WszgspnVAe79k2rUtyjzK+37kXhBtbn74JtvwTkmEOQfmgvDJAKZp65SM5sBMDn52
         KUOw==
X-Gm-Message-State: AAQBX9eLiixiMCESHmkxW3lcp/D3aNlSmkBrD29d1XT5uMOkNNl8PWnp
        iBzHww+ZrjDJ/ZUKaZCZQuTzMW2psOtDNJUOBBtFoWhNJyK1ApCoKrhcBIlywfGQeEtxDYiVRl7
        g00lZcjnwPcAs9f8wjFjP1LDo
X-Received: by 2002:a05:6214:27c6:b0:5ac:463b:a992 with SMTP id ge6-20020a05621427c600b005ac463ba992mr23570858qvb.0.1680000973765;
        Tue, 28 Mar 2023 03:56:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350YoJ1hu+cmlWRCRMngdhv9I0pHFod7SIKCQg1c/gYLu9JE0o2UCKpqfgcuCH709qp40s94LAw==
X-Received: by 2002:a05:6214:27c6:b0:5ac:463b:a992 with SMTP id ge6-20020a05621427c600b005ac463ba992mr23570827qvb.0.1680000973448;
        Tue, 28 Mar 2023 03:56:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-148.dyn.eolo.it. [146.241.232.148])
        by smtp.gmail.com with ESMTPSA id u13-20020a0cee8d000000b005dd8b9345f2sm3684704qvr.138.2023.03.28.03.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:56:12 -0700 (PDT)
Message-ID: <e6b7c24026e3750ea3e10a5ebf26bf2dd903e2a1.camel@redhat.com>
Subject: Re: [net-next Patch v5 5/6] octeontx2-pf: Add support for HTB
 offload
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net,
        willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, naveenm@marvel.com,
        edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, maxtram95@gmail.com
Date:   Tue, 28 Mar 2023 12:56:08 +0200
In-Reply-To: <20230326181245.29149-6-hkelam@marvell.com>
References: <20230326181245.29149-1-hkelam@marvell.com>
         <20230326181245.29149-6-hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-03-26 at 23:42 +0530, Hariprasad Kelam wrote:
[...]
> +static int otx2_qos_root_add(struct otx2_nic *pfvf, u16 htb_maj_id, u16 =
htb_defcls,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct otx2_qos_cfg *new_cfg;
> +	struct otx2_qos_node *root;
> +	int err;
> +
> +	netdev_dbg(pfvf->netdev,
> +		   "TC_HTB_CREATE: handle=3D0x%x defcls=3D0x%x\n",
> +		   htb_maj_id, htb_defcls);
> +
> +	INIT_LIST_HEAD(&pfvf->qos.qos_tree);
> +	mutex_init(&pfvf->qos.qos_lock);

It's quite strange and error prone dynamically init this mutex and the
list here. Why don't you do such init ad device creation time?

> +
> +	root =3D otx2_qos_alloc_root(pfvf);
> +	if (IS_ERR(root)) {
> +		mutex_destroy(&pfvf->qos.qos_lock);
> +		err =3D PTR_ERR(root);
> +		return err;
> +	}
> +
> +	/* allocate txschq queue */
> +	new_cfg =3D kzalloc(sizeof(*new_cfg), GFP_KERNEL);
> +	if (!new_cfg) {
> +		NL_SET_ERR_MSG_MOD(extack, "Memory allocation error");

Here the root node is leaked.

> +		mutex_destroy(&pfvf->qos.qos_lock);
> +		return -ENOMEM;
> +	}


[...]

Cheers,

Paolo

