Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E882662BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjAIQy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbjAIQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:53:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7140868
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:53:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so8824014wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 08:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6M2f+5hl6ycxEpjBTo7pStxA/gUi5ADO0lMaKR9JFY=;
        b=mZKdUV+QJVvlJnUlNUoT/kQoNbhSpp8TKFDoQbtzA9ccRgsHV1ngpLYb+wD3q5+qZI
         xdkaS/XCfHHymFPKkFxH55jQh13D+9YuCtBsLlRcFut0+UeE6MZg6MkPf+nsZM7x3EYG
         7HPnbDHTVZ3GNtS7maefT3yS7dDK02BGF/HUwkhM5UYokRVLzn53LGx3ruNNSMvPEqry
         kfOPqTD5VgBnnV9ZjKTkyTot51lduB7tUvTh4ZSeiU3r1eVROkloGQDmm+uCRDJE5dsk
         XjqqXsahAqBRoeV9juBgLUiOMGnHu/riQCeclPMP3eJd3DUG6gX4xGoJsAV2A5j2Gnh+
         r5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6M2f+5hl6ycxEpjBTo7pStxA/gUi5ADO0lMaKR9JFY=;
        b=Mac4jiBHO9jA/NVsA2giSK8vF+CHNYH9lLPMCPjMMGD7aZmoaNc/amws3GAP2nEIXU
         VdUh/Eq4i/5zANF4Md42dRr5r0yI9T4xqBL1E2QsbNDtwuplObqvBerT2JmJTHkfct2p
         QXEb3oiUbXgMXfhlsrm2pS2D0B9aBVHB4UV3AmUIzxrpM1Qv39u0PpU3EewXQqsz0CX/
         K0BAckIh47/qi+OQWmZ+Qso2ncR+X9l8uQCuK6+3THSDzAbTTwTld6DVI4fPCNlHr9uY
         Suwh0q+keE2dFsD/vC2XGnNg4o0z68NayykTyRsScmdGpvHT1g/uPqLf0wM8gWNvYXwX
         6Qrg==
X-Gm-Message-State: AFqh2kpOC2jXcWkTQ5HSStJx6O6aO5Qco7ZlbJcKsqDHSTbgfmOPgqbA
        4bmXWIbbaxgmXDKNFmldRF9JD34LMi8=
X-Google-Smtp-Source: AMrXdXsJJiszUF3JuTTX8Nmf8vVy4QgNmyu5UjoEDDbrHTlDop789Gmv81KRUfztvkaV2pEktbZHlA==
X-Received: by 2002:adf:e3d2:0:b0:299:51c8:5297 with SMTP id k18-20020adfe3d2000000b0029951c85297mr17551617wrm.66.1673283189102;
        Mon, 09 Jan 2023 08:53:09 -0800 (PST)
Received: from gmail.com ([31.46.247.25])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm9058068wrb.107.2023.01.09.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:53:08 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Jan 2023 17:53:04 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jpoimboe@redhat.com, peterz@infradead.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, mingo@redhat.com, christophe.leroy@csgroup.eu,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        sfr@canb.auug.org.au, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] objtool: continue if find_insn() fails in
 decode_instructions()
Message-ID: <Y7xGas4FAHFUtEJE@gmail.com>
References: <20221208072813.25799-1-sv@linux.ibm.com>
 <Y7lHsw4diDgVc9ip@gmail.com>
 <623307fe-a29a-c691-b07b-4d2168d4bdcc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <623307fe-a29a-c691-b07b-4d2168d4bdcc@linux.ibm.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sathvika Vasireddy <sv@linux.ibm.com> wrote:

> Hi Ingo, Happy New Year!

Happy New Year to you too! :-)

> On 07/01/23 15:51, Ingo Molnar wrote:
> > * Sathvika Vasireddy <sv@linux.ibm.com> wrote:
> > 
> > > Currently, decode_instructions() is failing if it is not able to find
> > > instruction, and this is happening since commit dbcdbdfdf137b4
> > > ("objtool: Rework instruction -> symbol mapping") because it is
> > > expecting instruction for STT_NOTYPE symbols.
> > > 
> > > Due to this, the following objtool warnings are seen:
> > >   [1] arch/powerpc/kernel/optprobes_head.o: warning: objtool: optprobe_template_end(): can't find starting instruction
> > >   [2] arch/powerpc/kernel/kvm_emul.o: warning: objtool: kvm_template_end(): can't find starting instruction
> > >   [3] arch/powerpc/kernel/head_64.o: warning: objtool: end_first_256B(): can't find starting instruction
> > > 
> > > The warnings are thrown because find_insn() is failing for symbols that
> > > are at the end of the file, or at the end of the section. Given how
> > > STT_NOTYPE symbols are currently handled in decode_instructions(),
> > > continue if the instruction is not found, instead of throwing warning
> > > and returning.
> > > 
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> > The SOB chain doesn't look valid: is Naveen N. Rao, the first SOB line, the
> > author of the patch? If yes then a matching From: line is needed.
> > 
> > Or if two people developed the patch, then Co-developed-by should be used:
> > 
> >          Co-developed-by: First Co-Author <first@coauthor.example.org>
> >          Signed-off-by: First Co-Author <first@coauthor.example.org>
> >          Co-developed-by: Second Co-Author <second@coauthor.example.org>
> >          Signed-off-by: Second Co-Author <second@coauthor.example.org>
> > 
> > [ In this SOB sequence "Second Co-Author" is the one who submits the patch. ]
> > 
> > [ Please only use Co-developed-by if actual lines of code were written by
> >    the co-author that created copyrightable material - it's not a courtesy
> >    tag. Reviewed-by/Acked-by/Tested-by can be used to credit non-code
> >    contributions. ]
> Thank you for the clarification, and for bringing these points to my
> attention. I'll keep these things in mind. In this case, since both Naveen
> N. Rao and I developed the patch, the below tags
> are applicable.
> 
>         Co-developed-by: First Co-Author <first@coauthor.example.org>
>         Signed-off-by: First Co-Author <first@coauthor.example.org>
>         Co-developed-by: Second Co-Author <second@coauthor.example.org>
>         Signed-off-by: Second Co-Author <second@coauthor.example.org>

... while filling in your real names & email addresses I suppose. ;-)

> 
> However, I would be dropping this particular patch, since I think Nick's
> patch [1] is better to fix the objtool issue.
> 
> [1] - https://lore.kernel.org/linuxppc-dev/20221220101323.3119939-1-npiggin@gmail.com/

Ok, I'll pick up Nick's fix, with these tags added for the PowerPC 
regression aspect and your review:

  Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
  Reported-by: Sathvika Vasireddy <sv@linux.ibm.com>
  Acked-by: Sathvika Vasireddy <sv@linux.ibm.com>

To document & credit the efforts of your patch.

Thanks,

	Ingo
