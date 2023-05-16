Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742C170482F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjEPIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEPIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08224494
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684227066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0q0sgrvIYyyF6O9U4atmmjpqy1XO7y6aYy7IyStT97o=;
        b=bOXL4dppIdJsh36Cp3PEOfZVrrSA7ngj0Ac5IUXtLx5MPvL5yu0BqW42dhD6wHSWI2EKSb
        4FxhgF16m4F60LL0gXwgcerhYw9LqVTZ2rtmN4AHxiPqwFqPF0aBWqMPEBuvduPpE5shlX
        6U/bh5xJolx2ympCyKY+2sXvmbTRhu0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-vdXUMRg2MDyFYuNK9pomJA-1; Tue, 16 May 2023 04:51:04 -0400
X-MC-Unique: vdXUMRg2MDyFYuNK9pomJA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f508c2b301so2938455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227063; x=1686819063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0q0sgrvIYyyF6O9U4atmmjpqy1XO7y6aYy7IyStT97o=;
        b=bH6FiSZOne0MDnBHPqKDGuwgnSVBZmzypH5Rr/iyyeKEJ6FzZ/LPjCkpJd0vuYAqEJ
         wA5iDkKZPcgZqYkj4pVwmLtVawDQWHGGDge3PlcYByYXBgl8SQJ+KMXDxJXICNfjmW77
         xBFVw1vgTxjYXom9ERlOXWX92W957XBibsx9yo5/8bFrKLgjCE/eNc2YsO7Wm6wX7Qco
         BgXntul39bVNgrMqZW9cnb+mcsjYBUJXE7Z+jXF2TMyKcJ/BiI2T0p/fX4K2jIpPFIJN
         obDIx5rGKxvJItXd9t8QvzkP5tlgPlBDP6EWzVLfufIs3oqSCO4JuD54rJi/mFZBPruv
         wmrA==
X-Gm-Message-State: AC+VfDz98fZBxmIkWOuEP0IkPLZLbEo0pyUfkhDXnKcG5PWl/zuzqi76
        Bngd5gRmMBk988yJm3KudgbVpzLd3kyzpM0AJgR3mvd1xniJN9c97u9A8K0Qb7HYbPee9iSJQl0
        4orOICsNE/MML3mAowPiGtm0g
X-Received: by 2002:a05:600c:1d86:b0:3f4:2297:f263 with SMTP id p6-20020a05600c1d8600b003f42297f263mr1974958wms.0.1684227063506;
        Tue, 16 May 2023 01:51:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cN31E0NJMMedOy9G9bqynpyxHDxn4MHX6HVSPUY6wUMCHR1v5LPGN/yP5HOeQW+HYYji4iQ==
X-Received: by 2002:a05:600c:1d86:b0:3f4:2297:f263 with SMTP id p6-20020a05600c1d8600b003f42297f263mr1974933wms.0.1684227063081;
        Tue, 16 May 2023 01:51:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-74.dyn.eolo.it. [146.241.225.74])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003f19b3d89e9sm1537023wmj.33.2023.05.16.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:51:02 -0700 (PDT)
Message-ID: <90a2c5891b435c7d3734e46a70cadb56e84865b6.camel@redhat.com>
Subject: Re: Re: [PATCH net-next] octeontx2-pf: Add support for page pool
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Date:   Tue, 16 May 2023 10:51:01 +0200
In-Reply-To: <MWHPR1801MB191862CDE18A98A89E57E3D9D3799@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20230515055607.651799-1-rkannoth@marvell.com>
         <c50a0969-4b17-f2c2-6ad6-b085b8ac4043@huawei.com>
         <MWHPR1801MB191862CDE18A98A89E57E3D9D3799@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 03:36 +0000, Ratheesh Kannoth wrote:
>=20
> > ....
> > > @@ -1170,15 +1199,24 @@ void otx2_free_aura_ptr(struct otx2_nic
> > > *pfvf,
> > int type)
> > > =C2=A0	/* Free SQB and RQB pointers from the aura pool */
> > > =C2=A0	for (pool_id =3D pool_start; pool_id < pool_end;
> > > pool_id++) {
> > > =C2=A0		iova =3D otx2_aura_allocptr(pfvf, pool_id);
> > > +		pool =3D &pfvf->qset.pool[pool_id];
> > > =C2=A0		while (iova) {
> > > =C2=A0			if (type =3D=3D AURA_NIX_RQ)
> > > =C2=A0				iova -=3D OTX2_HEAD_ROOM;
> > >=20
> > > =C2=A0			pa =3D otx2_iova_to_phys(pfvf-
> > > >iommu_domain,
> > iova);
> > > -			dma_unmap_page_attrs(pfvf->dev, iova,
> > > size,
> > > -					     DMA_FROM_DEVICE,
> > > -					   =20
> > > DMA_ATTR_SKIP_CPU_SYNC);
> > > -
> > > 			put_page(virt_to_page(phys_to_virt(pa)));
> > > +			page =3D virt_to_page(phys_to_virt(pa));
> >=20
> > virt_to_page() seems ok for order-0 page allocated from page pool
> > as it does
> > now, but it may break for order-1+ page as
> > page_pool_put_page() expects head page of compound page or base
> > page.
> > Maybe add a comment for that or use virt_to_head_page() explicitly.
> Thanks !!.=20
> >=20
> > > +
> > > +			if (pool->page_pool) {
> > > +				page_pool_put_page(pool-
> > > >page_pool,
> > page, size, true);
> >=20
> > page_pool_put_full_page() seems more appropriate here, as the
> > PP_FLAG_DMA_SYNC_DEV flag is not set, even if it is set, it seems
> > the whole
> > page need to be synced instead of a frag.
> Agree.=20
> >=20
> >=20
> > > +			} else {
> > > +				dma_unmap_page_attrs(pfvf->dev,
> > > iova,
> > size,
> > > +						   =20
> > > DMA_FROM_DEVICE,
> > > +
> > DMA_ATTR_SKIP_CPU_SYNC);
> > > +
> > > +				put_page(page);
> > > +			}
> > > +
> > > =C2=A0			iova =3D otx2_aura_allocptr(pfvf,
> > > pool_id);
> > > =C2=A0		}
> > > =C2=A0	}
> > > @@ -1196,6 +1234,8 @@ void otx2_aura_pool_free(struct otx2_nic
> > > *pfvf)
> > > =C2=A0		pool =3D &pfvf->qset.pool[pool_id];
> > > =C2=A0		qmem_free(pfvf->dev, pool->stack);
> > > =C2=A0		qmem_free(pfvf->dev, pool->fc_addr);
> > > +		page_pool_destroy(pool->page_pool);
> > > +		pool->page_pool =3D NULL;
> > > =C2=A0	}
> > > =C2=A0	devm_kfree(pfvf->dev, pfvf->qset.pool);
> > > =C2=A0	pfvf->qset.pool =3D NULL;
> > > @@ -1279,8 +1319,10 @@ static int otx2_aura_init(struct otx2_nic
> > > *pfvf, int aura_id,  }
> > >=20
> > > =C2=A0static int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
> > > -			  int stack_pages, int numptrs, int
> > > buf_size)
> > > +			  int stack_pages, int numptrs, int
> > > buf_size,
> > > +			  int type)
> > > =C2=A0{
> > > +	struct page_pool_params pp_params =3D { 0 };
> > > =C2=A0	struct npa_aq_enq_req *aq;
> > > =C2=A0	struct otx2_pool *pool;
> > > =C2=A0	int err;
> > > @@ -1324,6 +1366,22 @@ static int otx2_pool_init(struct otx2_nic
> > > *pfvf,
> > u16 pool_id,
> > > =C2=A0	aq->ctype =3D NPA_AQ_CTYPE_POOL;
> > > =C2=A0	aq->op =3D NPA_AQ_INSTOP_INIT;
> > >=20
> > > +	if (type !=3D AURA_NIX_RQ) {
> > > +		pool->page_pool =3D NULL;
> > > +		return 0;
> > > +	}
> > > +
> > > +	pp_params.flags =3D PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> > > +	pp_params.pool_size =3D numptrs;
> > > +	pp_params.nid =3D NUMA_NO_NODE;
> > > +	pp_params.dev =3D pfvf->dev;
> > > +	pp_params.dma_dir =3D DMA_FROM_DEVICE;
> > > +	pool->page_pool =3D page_pool_create(&pp_params);
> > > +	if (!pool->page_pool) {
> > > +		netdev_err(pfvf->netdev, "Creation of page pool
> > > failed\n");
> > > +		return -EFAULT;
> > > +	}
> > > +
> > > =C2=A0	return 0;
> > > =C2=A0}
> > >=20
> > > @@ -1358,7 +1416,7 @@ int otx2_sq_aura_pool_init(struct otx2_nic
> > > *pfvf)
> > >=20
> > > =C2=A0		/* Initialize pool context */
> > > =C2=A0		err =3D otx2_pool_init(pfvf, pool_id, stack_pages,
> > > -				     num_sqbs, hw->sqb_size);
> > > +				     num_sqbs, hw->sqb_size,
> > > AURA_NIX_SQ);
> > > =C2=A0		if (err)
> > > =C2=A0			goto fail;
> > > =C2=A0	}
> > > @@ -1421,7 +1479,7 @@ int otx2_rq_aura_pool_init(struct otx2_nic
> > > *pfvf)
> > > =C2=A0	}
> > > =C2=A0	for (pool_id =3D 0; pool_id < hw->rqpool_cnt; pool_id++) {
> > > =C2=A0		err =3D otx2_pool_init(pfvf, pool_id, stack_pages,
> > > -				     num_ptrs, pfvf->rbsize);
> > > +				     num_ptrs, pfvf->rbsize,
> > > AURA_NIX_RQ);
> > > =C2=A0		if (err)
> > > =C2=A0			goto fail;
> > > =C2=A0	}
> >=20
> > ...
> >=20
> > > diff --git
> > > a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > index 7045fedfd73a..df5f45aa6980 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > @@ -217,9 +217,10 @@ static bool otx2_skb_add_frag(struct
> > > otx2_nic
> > *pfvf, struct sk_buff *skb,
> > > =C2=A0		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> > > page,
> > > =C2=A0				va - page_address(page) + off,
> > > =C2=A0				len - off, pfvf->rbsize);
> > > -
> > > +#ifndef CONFIG_PAGE_POOL
> >=20
> > Most driver does 'select PAGE_POOL' in config when adding page pool
> > support, is there any reason it does not do it here?
> We thought about it. User should be able to use the driver without
> PAGE_POOL support.=20

Uhm... the above looks like a questionable choice, as page pull is a
small infra, and the performance delta should be relevant.

Anyway if you really want to use such strategy, please be consistent
and guard any relevant chunck of code with compiler guards. Likely it
would be better providing dummy helpers for the few page_pool functions
still missing them when !CONFIG_PAGE_POOL

>=20
Cheers,

Paolo

