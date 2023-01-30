Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E4680D64
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjA3MRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjA3MRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:17:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB6E3;
        Mon, 30 Jan 2023 04:17:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a3so4162086wrt.6;
        Mon, 30 Jan 2023 04:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uIlSiZXzAKFScUSHiJ+0tNApITPA2xK9uxvd2of89gg=;
        b=mMVX48jGVpOwVWYt8RsV3r0ZEEGDByr9P91Oon2ul08+ARTID2kf1ciNiuU69rIG81
         etSqOgcdasB0VsNd8K9gDkHyVEvifV3yjRk7oXHjR5X88+JcnuBgsJYhfp/wCeHNO/Mu
         f83SkKBdEsFuJgG8eBIJ8JEY3Cd2+dimAChU0mIHciavXBhIL8LbOWkUn6XiPAIUmuzH
         vjZC4VRIWkFTw/WNMjqLzGL8dbnT/jqbUU7KA6pW4pPzDTVW0ii0i2YeSKbdoZLbNmnI
         YtzL+ack3M1HKPSoeUyx+mQwFx2Kxixj3GnSh95Gsbs8RHBwZSf+9rTpjYTqftUzt55a
         n53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIlSiZXzAKFScUSHiJ+0tNApITPA2xK9uxvd2of89gg=;
        b=WYJ0Aaehk8g1SY7rv9AKJiYPLkoFgN6tGyq3VSnxQ7nxLKy8RQ/j/ntKgiW0759nSA
         icE1C4e8fpDn99fHkaqx+Yg9xcQrf8XqmSGyvYsFmPUW+Pe2vrLnyWp/48yhc2LPj2nX
         DFGq6I1Huc69gdrrbmAzlIEZCRTn9DaA6b2gxs/QWPudgU3cZMURME7WGuUTM+iOn/wW
         34n7sU98iIJH3C/1OS1eOVhhUoQx4s7MtIRo0FnVUWVjd5Ic4GsiDO8H7ClR6Lzy2IIS
         6xmMFgHOD7iIucnAFHP8doKXtYsuBChCbo3emqRIsXe3GdLind9nwsyEpKqLJb6oNqQH
         OzuQ==
X-Gm-Message-State: AO0yUKU/V1QEV8aHQlZvt8TzPHjfbyHWkn2ITNgJOT9kzjrrd2fnfaVZ
        Y4xROsfYTQslZV55gQ8Bjtn7aghq6AY=
X-Google-Smtp-Source: AK7set8pubIjJo9j0bilyXjoJlr/qj2/T46nIlrc8OjG12RALLCOO6f7cjhrWBqiFDOYMrRaP+p6wQ==
X-Received: by 2002:a05:6000:1247:b0:2bf:ecd8:c9f4 with SMTP id j7-20020a056000124700b002bfecd8c9f4mr3544372wrx.55.1675081024640;
        Mon, 30 Jan 2023 04:17:04 -0800 (PST)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k10-20020adff28a000000b002b9b9445149sm3257005wro.54.2023.01.30.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 04:17:04 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
X-Google-Original-From: Sudip Mukherjee <sudip@debian>
Date:   Mon, 30 Jan 2023 12:17:02 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: mainline build failure on arm hosts
Message-ID: <Y9e1PoEJgq3TPNtP@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The mainline kernel branch had been failing native build on arm hosts
for some weeks with the error:

drivers/crypto/caam/desc_constr.h: In function 'append_data.constprop':
./include/linux/fortify-string.h:57:29: error: argument 2 null where non-null expected [-Werror=nonnull]
   57 | #define __underlying_memcpy __builtin_memcpy
      |                             ^
./include/linux/fortify-string.h:578:2: note: in expansion of macro '__underlying_memcpy'
  578 |  __underlying_##op(p, q, __fortify_size);   \
      |  ^~~~~~~~~~~~~
./include/linux/fortify-string.h:623:26: note: in expansion of macro '__fortify_memcpy_chk'
  623 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/crypto/caam/desc_constr.h:167:3: note: in expansion of macro 'memcpy'
  167 |   memcpy(offset, data, len);
      |   ^~~~~~
./include/linux/fortify-string.h:57:29: note: in a call to built-in function '__builtin_memcpy'
   57 | #define __underlying_memcpy __builtin_memcpy
      |                             ^
./include/linux/fortify-string.h:578:2: note: in expansion of macro '__underlying_memcpy'
  578 |  __underlying_##op(p, q, __fortify_size);   \
      |  ^~~~~~~~~~~~~
./include/linux/fortify-string.h:623:26: note: in expansion of macro '__fortify_memcpy_chk'
  623 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/crypto/caam/desc_constr.h:167:3: note: in expansion of macro 'memcpy'
  167 |   memcpy(offset, data, len);
      |   ^~~~~~
cc1: all warnings being treated as errors


The commit 4f289826fee0 ("crypto: caam - Avoid GCC memset bug warning")
in linux-next fixes the build.


-- 
Regards
Sudip
