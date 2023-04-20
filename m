Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243976E9258
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjDTLWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjDTLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:21:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55E8A5C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:19:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dm2so5481099ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681989536; x=1684581536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WA0tasA6U86rCWy/tsTCUnCRVKE+XPwgQ4p6mQ9qAKg=;
        b=CFmzTcXSpQOMcHpLvK/nYp8KG6IObk3FmRZbv0YUtZz+vM6+uHU61/7E/8o0+uS12u
         u65cX649Hyrl4Btnp883plSbUR9JYCiogS74d5EOkYDy3lnw7furF9VMciDQNrVEnywe
         fskXFsX8Gx1tIxAC3douNOk//WSz3AKQj2q5Dbku5CnOW8hDvMzI67mWWizZkKLdeYqY
         IuxqI84ZJmUErbBb/IqmG8jhFsxpZy9/WL3a8ZyQSqH9DXSUfOks2FU+tXiYRuJVdxgG
         f+ZsuJMBi3Z1rTFD4C7YS3ntgu0B3ENELIctpfRFDhkr+M9TEshIEP6vwk9p/xXyaHDj
         93Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681989536; x=1684581536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA0tasA6U86rCWy/tsTCUnCRVKE+XPwgQ4p6mQ9qAKg=;
        b=jtV8bahEsGNqGcfgy34DuW3TMs9/NEXcNNz+DAsX00B0nbQIxpZ1M0YmIKOTfEoBLS
         2XNSUdIRBpc59VgofPCgdRMzYGaB+hKd/2q73r/xie+c9UlDT/oUynBBrlujIR1VqPJB
         z8T4BA7R099yB2bF5A8NUfNcAlxCYazajXxN8dkRIkUR2AyoD2CQjC4QVLIT0hmHjwdy
         bdePcBxR0o4IxXdwsTfMyAXGSSJ4hdv4Bq/gYA5OwqL+Ggr68zmQ5lwGfGKTMn/B1Zml
         vlZWlZWA/YwfUcWN19uvVHYb9GQYwVvTWqvMCTSYp9R1zM7PyHPFSj+kQhy4ELtcUUTM
         GAYA==
X-Gm-Message-State: AAQBX9cawwrVcZwnFRbs1Thswi5z4QouPvPnfhYW6W3SwI3Zi4E0Zbas
        E2DZzRVsYwXmiTFp8eEvWItVCASpfWSfMa92VSNce1Ij
X-Google-Smtp-Source: AKy350ax2IVjWl2a0PkWlvXki8MdAC5nMMF5AsQMfZw96qPpli1vj2QfaD1dIjR6B3oMQPbcfwZWPQ==
X-Received: by 2002:adf:f5c7:0:b0:2f7:af3a:72fc with SMTP id k7-20020adff5c7000000b002f7af3a72fcmr1017151wrp.27.1681988836036;
        Thu, 20 Apr 2023 04:07:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600010c400b002e45f6ffe63sm1711191wrx.26.2023.04.20.04.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 04:07:15 -0700 (PDT)
Date:   Thu, 20 Apr 2023 14:07:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Vicki Pfau <vi@endrift.com>,
        kernel-janitors@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>,
        hust-os-kernel-patches@googlegroups.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
Message-ID: <3ccc85bd-0541-4ffb-a207-dfc533a2c0aa@kili.mountain>
References: <20230414125603.686123-1-dzm91@hust.edu.cn>
 <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
 <011c00e7-c351-4331-8be4-1c184d5773e1@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wV+AKsNa2L4HcRBH"
Content-Disposition: inline
In-Reply-To: <011c00e7-c351-4331-8be4-1c184d5773e1@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wV+AKsNa2L4HcRBH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 01:42:21PM +0300, Dan Carpenter wrote:
> Btw, we should be thinking about how to detect these sorts of issues
> using static analysis.  Unfortunately, it's not as simple as saying
> "We know this variable is NULL so don't dereference it."  The problem
> with that is that many times Smatch sees where a pointer is set to NULL
> but not when it is assigned to a different value.
> 
> What we could do instead is say:
> 1) If a pointer is dereferenced and we know it is NULL then:
>     set_state_expr(my_id, expr, &suspicious);
> 2) If we set a pointer to non-NULL and it is marked as suspicious then
>    print a warning.

I was thinking about this and it's not so simple.  Normally after a
warning we return so the state never transitions from &suspicious to
non-NULL.

So what we could do is set the state to &suspicious.  Then at the end of
the function we look at all the states at the return paths.  If the
state is non-NULL on any return path then print a warning.  This is easy
enough to do, but requires quite a bit of Smatch knowledge so I have
done it.  Attached.

Unfortunately, it doesn't print a warning in this case because Smatch
doesn't track that _dev_warn() dereferences the "dev" pointer.  The
__dev_printk() function only dereferences "dev" if it is non-NULL.
Smatch only counts it if it *always* dereferences it.

This could be fixed in two steps:
Step 1: track dereferences based on the return insead just yes/no.
Step 2: split _dev_warn() returns into two returns based on if dev is
        NULL or non-NULL.

Step 1 is probably a good idea.  Step 2 is a bad idea, because it makes
no sense to pass a NULL to dev_warn().

A better approach for this bug is to print a warning if people pass
the address of the offset from a NULL pointer.  Combine that with the
same return states filter as earlier to eliminate false positives where
Smatch thinks a pointer is always NULL.

drivers/input/joystick/xpad.c:2053 xpad_probe() warn: address of NULL pointer 'xpad->dev'
drivers/media/i2c/ccs/ccs-data.c:524 ccs_data_parse_rules() warn: address of NULL pointer 'rules'
drivers/scsi/lpfc/lpfc_attr.c:1482 lpfc_reset_pci_bus() warn: address of NULL pointer 'phba->pcidev'

That check is attached too.

regards,
dan carpenter


--wV+AKsNa2L4HcRBH
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_deref_before_set.c"

/*
 * Copyright 2023 Linaro Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_extra.h"
#include "smatch_slist.h"

static int my_id;

STATE(suspicious);

static void deref_hook(struct expression *expr)
{
	sval_t sval;

	if (!get_implied_value(expr, &sval) || sval.value != 0)
		return;
	set_state_expr(my_id, expr, &suspicious);
}

static void check_variable(struct sm_state *sm)
{
	struct sm_state *extra_sm, *tmp;

	extra_sm = get_sm_state(SMATCH_EXTRA, sm->name, sm->sym);
	if (!extra_sm)
		return;

	FOR_EACH_PTR(extra_sm->possible, tmp) {
		if (!estate_rl(tmp->state))
			continue;
		if (rl_min(estate_rl(tmp->state)).value != 0) {
			sm_warning_line(sm->line,
				"pointer dereferenced without being set '%s'",
				sm->name);
			return;
		}
	} END_FOR_EACH_PTR(tmp);
}

static void process_states(void)
{
	struct sm_state *tmp;

	FOR_EACH_MY_SM(my_id, __get_cur_stree(), tmp) {
		check_variable(tmp);
	} END_FOR_EACH_SM(tmp);
}

void check_deref_before_set(int id)
{
	my_id = id;

	add_dereference_hook(deref_hook);
	all_return_states_hook(&process_states);
}

--wV+AKsNa2L4HcRBH
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_bogus_address_param.c"

/*
 * Copyright (C) 2019 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_extra.h"
#include "smatch_slist.h"

static int my_id;

STATE(suspicious);

static void check_param(struct expression *expr)
{
	struct expression *tmp;
	sval_t sval;

	tmp = get_assigned_expr(expr);
	if (tmp)
		expr = tmp;
	expr = strip_expr(expr);
	if (!expr || expr->type != EXPR_PREOP || expr->op != '&')
		return;
	if (!get_implied_value(expr, &sval) ||
	    sval.value == 0 || sval.uvalue > 4096)
		return;

	expr = strip_expr(expr->unop);
	while (expr->type == EXPR_DEREF) {
		expr = strip_expr(expr->deref);
		if (expr->type == EXPR_PREOP && expr->op == '*')
			expr = strip_expr(expr->unop);
		if (local_debug) {
			struct range_list *rl;
			get_absolute_rl(expr, &rl);
			sm_msg("%s: expr='%s' type=%d rl='%s'", __func__, expr_to_str(expr), expr->type, show_rl(rl));
		}
		if (get_implied_value(expr, &sval) && sval.value == 0) {
			set_state_expr(my_id, expr, &suspicious);
			return;
		}
	}
}

static void match_call(struct expression *expr)
{
	struct expression *arg;

	FOR_EACH_PTR(expr->args, arg) {
		check_param(arg);
	} END_FOR_EACH_PTR(arg);
}

static void check_variable(struct sm_state *sm)
{
	struct sm_state *extra_sm, *tmp;
	int line = sm->line;

	extra_sm = get_sm_state(SMATCH_EXTRA, sm->name, sm->sym);
	if (!extra_sm)
		return;

	FOR_EACH_PTR(sm->possible, tmp) {
		if (tmp->state == &suspicious)
			line = tmp->line;
	} END_FOR_EACH_PTR(tmp);

	FOR_EACH_PTR(extra_sm->possible, tmp) {
		if (!estate_rl(tmp->state))
			continue;
		if (rl_min(estate_rl(tmp->state)).value != 0) {
			sm_warning_line(line, "address of NULL pointer '%s'",
				        sm->name);
			return;
		}
	} END_FOR_EACH_PTR(tmp);
}

static void process_states(void)
{
	struct sm_state *tmp;

	FOR_EACH_MY_SM(my_id, __get_cur_stree(), tmp) {
		check_variable(tmp);
	} END_FOR_EACH_SM(tmp);
}

void check_bogus_address_param(int id)
{
	my_id = id;

	add_hook(&match_call, FUNCTION_CALL_HOOK);
	all_return_states_hook(&process_states);
}

--wV+AKsNa2L4HcRBH--
