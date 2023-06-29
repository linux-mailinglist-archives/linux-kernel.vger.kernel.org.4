Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B4742B10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF2RLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2RLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:11:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA903593
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:11:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d9890f368so1094235a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688058669; x=1690650669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wHVxA/tARHfaEgC7g7LRlEaSRUrsBDzjn3AmOaJO4eE=;
        b=a49g53g+GXunpTGRaC+7aq2PdvpzTPdmPfT5HSmpQtdBwI5WdGbbEZdfalgO0oNKnF
         3MKQWyYT6MFWqfeIDQrjoEr4wTsAziD6bBuQ9QgxMyj1bLyAv+SDDuMPoJH/UWdgv8Ir
         fm+F+F7LYQv7bcMKW+aGommk20mTx368thr1K25uuhjeUlJR32fHGWWiANke0f8H0CIX
         Ldt3LBu7tUxheonCOPBwajHWsyl6QrUwpDzdXblzlqgfVhpZtlBCDA9EtgI8GHHrHnqD
         Qa1wy3FIjgPtkCwFuRIR+IIAH74/6CZWkyfZK+ADdUVnwiaz+pbVo3ZjQyJudxeyz6po
         kaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688058669; x=1690650669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHVxA/tARHfaEgC7g7LRlEaSRUrsBDzjn3AmOaJO4eE=;
        b=IaykBqkQN6VpwIUzhCvTS1Qbw93yD0qsInm43j+BYXSN/vhU3GcHUVnNlbp+o04JnX
         4TLLpdMys44Mp/KAAUuOwr0enLbcDzCuZqAKaxIkKTQ7HrHqPTTOUBY0vWfJBZPW841Q
         15wIlqgJhgjX9XUS4tUGk+HXOQP+fYAiyCbvlm731XTbPrcDIx8k/XAxzO3ch0J8Axy/
         /qZGiFXrat7j90WfmVyBFVrRCNEdQm/ihNCMH88K3b6E2SUX5w5SocaLkQ8oPMUxtlnS
         Q4mrT/TpPRhrbaCs+GoU9AavelA2mk7AnOYVOCoUi/5heMdY+1HtPJ9xdMZhP9E9HN2u
         DN6g==
X-Gm-Message-State: AC+VfDweoStgILyGGrgpg1L+90ffi/nHCp5B/BLNZpp+yif5Kx5gTZhq
        z184f28ykTtiszzqWG3mEZ4VPonYOkd3MpU85/BWMMVS4Ld/lyY45XlC5Q==
X-Google-Smtp-Source: APBJJlGUa/dkBHaReVpn3ye5eHTAq1jWYI0mUSp+3j9ZrVB/zyZsPGsaVxkaXq0GffxzXVnXFSRj127PxuMgNV/Pttc=
X-Received: by 2002:a17:907:118d:b0:992:6d62:42e1 with SMTP id
 uz13-20020a170907118d00b009926d6242e1mr86649ejb.29.1688058669293; Thu, 29 Jun
 2023 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230629161044.1995505-1-matteorizzo@google.com> <599ba86b-1f33-4ba2-5781-cd98ecfa985c@infradead.org>
In-Reply-To: <599ba86b-1f33-4ba2-5781-cd98ecfa985c@infradead.org>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Thu, 29 Jun 2023 19:10:57 +0200
Message-ID: <CAHKB1wKdwG1UOaHER-zQQhDw8fVpM6uJZHESgzgEVURfH66JtA@mail.gmail.com>
Subject: Re: [PATCH] umh: fix build warning with CONFIG_SYSCTL disabled
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jarkko@kernel.org, mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 18:21, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Arnd sent this same patch on 2023-June-07.
>
> I have been wondering why it has not been merged...

Oh I see. I tried to search for the ID of the buggy commit but for some reason
I didn't see Arnd's patch. Thanks for pointing that out.

--
Matteo
