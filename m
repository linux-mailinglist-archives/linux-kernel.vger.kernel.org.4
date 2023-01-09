Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0EE661FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjAII3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbjAII2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:28:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0313B13F2A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:28:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s9so7322816wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZD8nI6HmMRloYqzFGgqolre6xt24UiKp8QgiomAAV0=;
        b=MAIAO/g3hRfcjMG2+wehmEXGkdnof3Yv0jObG/5u/FijhaqafBJacsmNtJGw5KaeBV
         XzNK9+7mkifcNWnK5UbBUcjQNXDRyvC58ecLs++K6FbKsdz+B4Oqb6hsxtnf263qnZrG
         QgFHpyZveCBu3BeKcASABYdsIIc7lydy/hUshLypcyUkymne8e1WJHwQhCVXHVYijaGs
         ic+daE5T7NGDuxATPMFIGZPfvCJpHyow8YFWoEJVot+nJ98tJgoOL3AwYPsxueex5XAn
         yo7J1HyOE4F/LK8TazR9QhBHablGnbAqOnQvGV1Wi34JgVvcjeAPutkuPNFNLc3hG9D1
         nA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZD8nI6HmMRloYqzFGgqolre6xt24UiKp8QgiomAAV0=;
        b=1rIXp29wALNKUS5lE/+gznMJnqAB9kBqZ8z+Qdclt0KpeZKCtG+j/i6f0/8cmwaDf6
         SXz9b8KlH0hhv2Pu86rCusul6nJV2YmfaO6/5KCHSGQETyj7cufjA/+ityIXtMwD6nv1
         MwfANfLK9WEwbxyl/NEVXNbXbMt2mFXu1EwMImWPgH2wDmZ6QMxeZO3guItLRoAlC7Z7
         amWnLWCy6fA00GazrUWMBJ6J3jCxUTh9Vr2p0NybT/GLJoW1g0IIau3lqJyB4hMvvEZW
         EqVXQmQxyWstu5OqJ8crdZi+89V4rzkDgI+fOKVTn3lLU54jFgtYnEamVMcFcW32mNqu
         ZCRw==
X-Gm-Message-State: AFqh2kqHSQAJOtFWEcsVhwj2SScMfnyy9LSMUCYV+40Lntqkd5AUqf1F
        1IIc/XIWGrgD8kT95BCnsBf0VVRB6ic=
X-Google-Smtp-Source: AMrXdXtxtAUjXlIqrSHiEq3e/a6f4hT44NKa7QdS3bzrMoFgY14FmgJg6dUfzzv9/b9kOiy/OIl3MA==
X-Received: by 2002:adf:f7ca:0:b0:29b:7aed:e06a with SMTP id a10-20020adff7ca000000b0029b7aede06amr15003626wrq.51.1673252881446;
        Mon, 09 Jan 2023 00:28:01 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe64a000000b00287da7ee033sm7856037wrn.46.2023.01.09.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:28:01 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:27:57 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/at_hdmac.c:1371 atc_prep_slave_sg() warn: possible
 memory leak of 'desc'
Message-ID: <202301090801.GNFV0WjT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
commit: ac803b56860f6506c55a3c9330007837e3f4edda dmaengine: at_hdmac: Convert driver to use virt-dma
config: arm-randconfig-m031-20230108
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/dma/at_hdmac.c:1371 atc_prep_slave_sg() warn: possible memory leak of 'desc'

vim +/desc +1371 drivers/dma/at_hdmac.c

808347f6a31792 Nicolas Ferre     2009-07-22  1235  static struct dma_async_tx_descriptor *
808347f6a31792 Nicolas Ferre     2009-07-22  1236  atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
db8196df4bb6f1 Vinod Koul        2011-10-13  1237  		unsigned int sg_len, enum dma_transfer_direction direction,
185ecb5f4fd439 Alexandre Bounine 2012-03-08  1238  		unsigned long flags, void *context)
808347f6a31792 Nicolas Ferre     2009-07-22  1239  {
ac803b56860f65 Tudor Ambarus     2022-10-25  1240  	struct at_dma		*atdma = to_at_dma(chan->device);
808347f6a31792 Nicolas Ferre     2009-07-22  1241  	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
808347f6a31792 Nicolas Ferre     2009-07-22  1242  	struct at_dma_slave	*atslave = chan->private;
beeaa103eecc7a Nicolas Ferre     2012-03-14  1243  	struct dma_slave_config	*sconfig = &atchan->dma_sconfig;
ac803b56860f65 Tudor Ambarus     2022-10-25  1244  	struct at_desc		*desc;
808347f6a31792 Nicolas Ferre     2009-07-22  1245  	u32			ctrla;
808347f6a31792 Nicolas Ferre     2009-07-22  1246  	u32			ctrlb;
808347f6a31792 Nicolas Ferre     2009-07-22  1247  	dma_addr_t		reg;
808347f6a31792 Nicolas Ferre     2009-07-22  1248  	unsigned int		reg_width;
808347f6a31792 Nicolas Ferre     2009-07-22  1249  	unsigned int		mem_width;
808347f6a31792 Nicolas Ferre     2009-07-22  1250  	unsigned int		i;
808347f6a31792 Nicolas Ferre     2009-07-22  1251  	struct scatterlist	*sg;
808347f6a31792 Nicolas Ferre     2009-07-22  1252  	size_t			total_len = 0;
808347f6a31792 Nicolas Ferre     2009-07-22  1253  
cc52a10a048fc1 Nicolas Ferre     2011-04-30  1254  	dev_vdbg(chan2dev(chan), "prep_slave_sg (%d): %s f0x%lx\n",
cc52a10a048fc1 Nicolas Ferre     2011-04-30  1255  			sg_len,
db8196df4bb6f1 Vinod Koul        2011-10-13  1256  			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
808347f6a31792 Nicolas Ferre     2009-07-22  1257  			flags);
808347f6a31792 Nicolas Ferre     2009-07-22  1258  
808347f6a31792 Nicolas Ferre     2009-07-22  1259  	if (unlikely(!atslave || !sg_len)) {
c618a9be0e8c0f Nicolas Ferre     2012-09-11  1260  		dev_dbg(chan2dev(chan), "prep_slave_sg: sg length is zero!\n");
808347f6a31792 Nicolas Ferre     2009-07-22  1261  		return NULL;
808347f6a31792 Nicolas Ferre     2009-07-22  1262  	}
808347f6a31792 Nicolas Ferre     2009-07-22  1263  
ac803b56860f65 Tudor Ambarus     2022-10-25  1264  	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);

New allocation.

ac803b56860f65 Tudor Ambarus     2022-10-25  1265  	if (!desc)
ac803b56860f65 Tudor Ambarus     2022-10-25  1266  		return NULL;
ac803b56860f65 Tudor Ambarus     2022-10-25  1267  	desc->sglen = sg_len;
ac803b56860f65 Tudor Ambarus     2022-10-25  1268  
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1269  	ctrla = FIELD_PREP(ATC_SCSIZE, sconfig->src_maxburst) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1270  		FIELD_PREP(ATC_DCSIZE, sconfig->dst_maxburst);
ae14d4b5e0a4eb Nicolas Ferre     2011-04-30  1271  	ctrlb = ATC_IEN;
808347f6a31792 Nicolas Ferre     2009-07-22  1272  
808347f6a31792 Nicolas Ferre     2009-07-22  1273  	switch (direction) {
db8196df4bb6f1 Vinod Koul        2011-10-13  1274  	case DMA_MEM_TO_DEV:
beeaa103eecc7a Nicolas Ferre     2012-03-14  1275  		reg_width = convert_buswidth(sconfig->dst_addr_width);
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1276  		ctrla |= FIELD_PREP(ATC_DST_WIDTH, reg_width);
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1277  		ctrlb |= FIELD_PREP(ATC_DST_ADDR_MODE,
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1278  				    ATC_DST_ADDR_MODE_FIXED) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1279  			 FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_INCR) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1280  			 FIELD_PREP(ATC_FC, ATC_FC_MEM2PER) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1281  			 FIELD_PREP(ATC_SIF, atchan->mem_if) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1282  			 FIELD_PREP(ATC_DIF, atchan->per_if);
beeaa103eecc7a Nicolas Ferre     2012-03-14  1283  		reg = sconfig->dst_addr;
808347f6a31792 Nicolas Ferre     2009-07-22  1284  		for_each_sg(sgl, sg, sg_len, i) {
ac803b56860f65 Tudor Ambarus     2022-10-25  1285  			struct atdma_sg *atdma_sg = &desc->sg[i];
ac803b56860f65 Tudor Ambarus     2022-10-25  1286  			struct at_lli *lli;
808347f6a31792 Nicolas Ferre     2009-07-22  1287  			u32		len;
808347f6a31792 Nicolas Ferre     2009-07-22  1288  			u32		mem;
808347f6a31792 Nicolas Ferre     2009-07-22  1289  
ac803b56860f65 Tudor Ambarus     2022-10-25  1290  			atdma_sg->lli = dma_pool_alloc(atdma->lli_pool,
ac803b56860f65 Tudor Ambarus     2022-10-25  1291  						       GFP_NOWAIT,
ac803b56860f65 Tudor Ambarus     2022-10-25  1292  						       &atdma_sg->lli_phys);
ac803b56860f65 Tudor Ambarus     2022-10-25  1293  			if (!atdma_sg->lli)
808347f6a31792 Nicolas Ferre     2009-07-22  1294  				goto err_desc_get;
ac803b56860f65 Tudor Ambarus     2022-10-25  1295  			lli = atdma_sg->lli;
808347f6a31792 Nicolas Ferre     2009-07-22  1296  
0f70e8cea3ac6a Nicolas Ferre     2010-12-15  1297  			mem = sg_dma_address(sg);
808347f6a31792 Nicolas Ferre     2009-07-22  1298  			len = sg_dma_len(sg);
c456797681db81 Nicolas Ferre     2012-09-11  1299  			if (unlikely(!len)) {
c456797681db81 Nicolas Ferre     2012-09-11  1300  				dev_dbg(chan2dev(chan),
c456797681db81 Nicolas Ferre     2012-09-11  1301  					"prep_slave_sg: sg(%d) data length is zero\n", i);
c456797681db81 Nicolas Ferre     2012-09-11  1302  				goto err;
c456797681db81 Nicolas Ferre     2012-09-11  1303  			}
808347f6a31792 Nicolas Ferre     2009-07-22  1304  			mem_width = 2;
808347f6a31792 Nicolas Ferre     2009-07-22  1305  			if (unlikely(mem & 3 || len & 3))
808347f6a31792 Nicolas Ferre     2009-07-22  1306  				mem_width = 0;
808347f6a31792 Nicolas Ferre     2009-07-22  1307  
ac803b56860f65 Tudor Ambarus     2022-10-25  1308  			lli->saddr = mem;
ac803b56860f65 Tudor Ambarus     2022-10-25  1309  			lli->daddr = reg;
ac803b56860f65 Tudor Ambarus     2022-10-25  1310  			lli->ctrla = ctrla |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1311  				     FIELD_PREP(ATC_SRC_WIDTH, mem_width) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1312  				     len >> mem_width;
ac803b56860f65 Tudor Ambarus     2022-10-25  1313  			lli->ctrlb = ctrlb;
808347f6a31792 Nicolas Ferre     2009-07-22  1314  
ac803b56860f65 Tudor Ambarus     2022-10-25  1315  			atdma_sg->len = len;
808347f6a31792 Nicolas Ferre     2009-07-22  1316  			total_len += len;
ac803b56860f65 Tudor Ambarus     2022-10-25  1317  
ac803b56860f65 Tudor Ambarus     2022-10-25  1318  			desc->sg[i].len = len;
ac803b56860f65 Tudor Ambarus     2022-10-25  1319  			atdma_lli_chain(desc, i);
808347f6a31792 Nicolas Ferre     2009-07-22  1320  		}
808347f6a31792 Nicolas Ferre     2009-07-22  1321  		break;
db8196df4bb6f1 Vinod Koul        2011-10-13  1322  	case DMA_DEV_TO_MEM:
beeaa103eecc7a Nicolas Ferre     2012-03-14  1323  		reg_width = convert_buswidth(sconfig->src_addr_width);
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1324  		ctrla |= FIELD_PREP(ATC_SRC_WIDTH, reg_width);
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1325  		ctrlb |= FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1326  			 FIELD_PREP(ATC_SRC_ADDR_MODE,
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1327  				    ATC_SRC_ADDR_MODE_FIXED) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1328  			 FIELD_PREP(ATC_FC, ATC_FC_PER2MEM) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1329  			 FIELD_PREP(ATC_SIF, atchan->per_if) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1330  			 FIELD_PREP(ATC_DIF, atchan->mem_if);
808347f6a31792 Nicolas Ferre     2009-07-22  1331  
beeaa103eecc7a Nicolas Ferre     2012-03-14  1332  		reg = sconfig->src_addr;
808347f6a31792 Nicolas Ferre     2009-07-22  1333  		for_each_sg(sgl, sg, sg_len, i) {
ac803b56860f65 Tudor Ambarus     2022-10-25  1334  			struct atdma_sg *atdma_sg = &desc->sg[i];
ac803b56860f65 Tudor Ambarus     2022-10-25  1335  			struct at_lli *lli;
808347f6a31792 Nicolas Ferre     2009-07-22  1336  			u32		len;
808347f6a31792 Nicolas Ferre     2009-07-22  1337  			u32		mem;
808347f6a31792 Nicolas Ferre     2009-07-22  1338  
ac803b56860f65 Tudor Ambarus     2022-10-25  1339  			atdma_sg->lli = dma_pool_alloc(atdma->lli_pool,
ac803b56860f65 Tudor Ambarus     2022-10-25  1340  						       GFP_NOWAIT,
ac803b56860f65 Tudor Ambarus     2022-10-25  1341  						       &atdma_sg->lli_phys);
ac803b56860f65 Tudor Ambarus     2022-10-25  1342  			if (!atdma_sg->lli)
808347f6a31792 Nicolas Ferre     2009-07-22  1343  				goto err_desc_get;
ac803b56860f65 Tudor Ambarus     2022-10-25  1344  			lli = atdma_sg->lli;
808347f6a31792 Nicolas Ferre     2009-07-22  1345  
0f70e8cea3ac6a Nicolas Ferre     2010-12-15  1346  			mem = sg_dma_address(sg);
808347f6a31792 Nicolas Ferre     2009-07-22  1347  			len = sg_dma_len(sg);
c456797681db81 Nicolas Ferre     2012-09-11  1348  			if (unlikely(!len)) {
c456797681db81 Nicolas Ferre     2012-09-11  1349  				dev_dbg(chan2dev(chan),
c456797681db81 Nicolas Ferre     2012-09-11  1350  					"prep_slave_sg: sg(%d) data length is zero\n", i);
c456797681db81 Nicolas Ferre     2012-09-11  1351  				goto err;
c456797681db81 Nicolas Ferre     2012-09-11  1352  			}
808347f6a31792 Nicolas Ferre     2009-07-22  1353  			mem_width = 2;
808347f6a31792 Nicolas Ferre     2009-07-22  1354  			if (unlikely(mem & 3 || len & 3))
808347f6a31792 Nicolas Ferre     2009-07-22  1355  				mem_width = 0;
808347f6a31792 Nicolas Ferre     2009-07-22  1356  
ac803b56860f65 Tudor Ambarus     2022-10-25  1357  			lli->saddr = reg;
ac803b56860f65 Tudor Ambarus     2022-10-25  1358  			lli->daddr = mem;
ac803b56860f65 Tudor Ambarus     2022-10-25  1359  			lli->ctrla = ctrla |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1360  				     FIELD_PREP(ATC_DST_WIDTH, mem_width) |
d8840a7edcf0aa Tudor Ambarus     2022-10-25  1361  				     len >> reg_width;
ac803b56860f65 Tudor Ambarus     2022-10-25  1362  			lli->ctrlb = ctrlb;
808347f6a31792 Nicolas Ferre     2009-07-22  1363  
ac803b56860f65 Tudor Ambarus     2022-10-25  1364  			desc->sg[i].len = len;
808347f6a31792 Nicolas Ferre     2009-07-22  1365  			total_len += len;
ac803b56860f65 Tudor Ambarus     2022-10-25  1366  
ac803b56860f65 Tudor Ambarus     2022-10-25  1367  			atdma_lli_chain(desc, i);
808347f6a31792 Nicolas Ferre     2009-07-22  1368  		}
808347f6a31792 Nicolas Ferre     2009-07-22  1369  		break;
808347f6a31792 Nicolas Ferre     2009-07-22  1370  	default:
808347f6a31792 Nicolas Ferre     2009-07-22 @1371  		return NULL;

kfree(desc) before returning.

808347f6a31792 Nicolas Ferre     2009-07-22  1372  	}
808347f6a31792 Nicolas Ferre     2009-07-22  1373  
808347f6a31792 Nicolas Ferre     2009-07-22  1374  	/* set end-of-link to the last link descriptor of list*/
ac803b56860f65 Tudor Ambarus     2022-10-25  1375  	set_lli_eol(desc, i - 1);
808347f6a31792 Nicolas Ferre     2009-07-22  1376  
ac803b56860f65 Tudor Ambarus     2022-10-25  1377  	desc->total_len = total_len;
bdf6c79278b3fb Torsten Fleischer 2015-02-23  1378  
ac803b56860f65 Tudor Ambarus     2022-10-25  1379  	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
808347f6a31792 Nicolas Ferre     2009-07-22  1380  
808347f6a31792 Nicolas Ferre     2009-07-22  1381  err_desc_get:
808347f6a31792 Nicolas Ferre     2009-07-22  1382  	dev_err(chan2dev(chan), "not enough descriptors available\n");
c456797681db81 Nicolas Ferre     2012-09-11  1383  err:
ac803b56860f65 Tudor Ambarus     2022-10-25  1384  	atdma_desc_free(&desc->vd);
808347f6a31792 Nicolas Ferre     2009-07-22  1385  	return NULL;
808347f6a31792 Nicolas Ferre     2009-07-22  1386  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

